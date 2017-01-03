//
//  TSChatShareMoreView.swift
//  TSWeChat
//
//  Created by Hilen on 12/24/15.
//  Modified by MT on 17 Jan 01
//

import UIKit
import SnapKit
import RxSwift
import RxBlocking
import Dollar

private let kLeftRightPadding: CGFloat = 15.0
private let kTopBottomPadding: CGFloat = 5.0
private let kItemCountOfRow: CGFloat = 1

private let totalNumOfOptions: CGFloat = 3


class TSChatShareMoreView: UIView {
    
    //TS-006
    var calculatedShareItemSize: CGSize!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var listCollectionView: UICollectionView! {didSet {
        listCollectionView.scrollsToTop = false
        }}
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    weak var delegate: ChatShareMoreViewDelegate?
    internal let disposeBag = DisposeBag()

    fileprivate let itemDataSouce: [(name: String, iconImage: UIImage)] = [
        ("很困 ...", TSAsset.Sharemore_voiceinput.image),
        ("四川豆花还是海底捞？", TSAsset.Sharemore_voiceinput.image),
        ("Test Wrap Auto DS-003 ", TSAsset.Sharemore_voiceinput.image),
//        ("视频聊天", TSAsset.Sharemore_videovoip.image),
//        ("红包", TSAsset.Sharemore_wallet.image),  //Where is the lucky money icon!  T.T
//        ("转账", TSAsset.SharemorePay.image),
//        ("位置", TSAsset.Sharemore_location.image),
//        ("收藏", TSAsset.Sharemore_myfav.image),
//        ("个人名片", TSAsset.Sharemore_friendcard.image),
//        ("语音输入", TSAsset.Sharemore_voiceinput.image),
//        ("卡券", TSAsset.Sharemore_wallet.image),
    ]
    fileprivate var groupDataSouce = [[(name: String, iconImage: UIImage)]]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.initialize()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.initialize()
    }
    
    func initialize() {
        
    }
    
    override func awakeFromNib() {
        print(">>> TSChatShareMoveView awakeFromNib")
        let layout = TSFullyHorizontalFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(
            kTopBottomPadding,
            kLeftRightPadding,
            kTopBottomPadding,
            kLeftRightPadding
        )
        //Calculate the UICollectionViewCell size
        let itemSizeWidth = (UIScreen.ts_width - kLeftRightPadding*2 - layout.minimumLineSpacing*(kItemCountOfRow - 1)) / kItemCountOfRow
        
        //Calculate how many row we need:
        let numOfRow = ceil(totalNumOfOptions/kItemCountOfRow)
        
        let itemSizeHeight = (self.collectionViewHeightConstraint.constant - kTopBottomPadding*2)/numOfRow
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        
        print("")
        print("layout.itemSize")
        print("------------ ",layout.itemSize)
        self.calculatedShareItemSize = layout.itemSize
        print("calculatedShareItemSize width")
        print("------------ ",calculatedShareItemSize.width)
        print("")
        
//        //TS-006 resize buttn size
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSChatShareMoreCollectionViewCell.identifier, for: indexPath) as! TSChatShareMoreCollectionViewCell
        
        self.listCollectionView.collectionViewLayout = layout
        self.listCollectionView.register(TSChatShareMoreCollectionViewCell.ts_Nib(), forCellWithReuseIdentifier: TSChatShareMoreCollectionViewCell.identifier)
        self.listCollectionView.showsHorizontalScrollIndicator = false
        self.listCollectionView.isPagingEnabled = true
        
        /**
        The section count is come from the groupDataSource, and The pageControl.numberOfPages is equal to the groupDataSouce.count.
        So I cut the itemDataSouce into 2 arrays. And the UICollectionView will has 2 sections.
        And then set the minimumLineSpacing and sectionInset of the flowLayout. The UI will be perfect like WeChat.
        */
        self.groupDataSouce = $.chunk(self.itemDataSouce,
                                      size: Int(kItemCountOfRow)*Int(totalNumOfOptions))
        self.pageControl.numberOfPages = self.groupDataSouce.count
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Fix the width
        self.listCollectionView.width = UIScreen.ts_width
    }

}

// MARK: - @protocol UICollectionViewDelegate
//TS-006 $$ Selections was clicked $$
extension TSChatShareMoreView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else {
            return
        }
        
        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ - clicked : ",indexPath)
        let section = indexPath.section
        let row = indexPath.row
        if section == 0 {
            if row == 0 {
                print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ - clicked : ",indexPath.row)
//                delegate.chatShareMoreViewPhotoTaped()
            } else if row == 1 {
                print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ - clicked : ",indexPath.row)
//                delegate.chatShareMoreViewCameraTaped()
            }
        }
        //TS-006 Get the information from data source
        
        guard let subArray = self.groupDataSouce.get(index: indexPath.section) else {
            print("DQ issue : ",indexPath, "no data found in datasource")
            return
        }
        
        if let item = subArray.get(index: indexPath.row) {
            print("======> Sending text ",item.name)
            //TS-006 close the details and send out message
            delegate.chatShareMoreViewMinTab_showShareKeyboard( item.name)
        }else{
            print("DQ issue : ",indexPath.row, "no data found in indexPath.row")
        }
        
        

        
        
    }
}


// MARK: - @protocol UICollectionViewDataSource
extension TSChatShareMoreView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.groupDataSouce.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let subArray = self.groupDataSouce.get(index: section) else {
            return 0
        }
        return subArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TS-006 Detail selection - Init
        print("*************** Init collectionView cellForItemAt",indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TSChatShareMoreCollectionViewCell.identifier, for: indexPath) as! TSChatShareMoreCollectionViewCell
        guard let subArray = self.groupDataSouce.get(index: indexPath.section) else {
            return TSChatShareMoreCollectionViewCell()
        }
        if let item = subArray.get(index: indexPath.row) {
//            cell.itemButton.setImage(item.iconImage, for: .normal)
            cell.itemButton.ts_setBackgroundColor(.green, forState: .normal)
//            cell.itemLabel.text = item.name
            cell.itemButton.setTitle(item.name, for: .normal)
            //TS-006 make share items fill full line, need to remove constraints from xib
//            cell.itemButton.ts_width = self.calculatedShareItemSize.width
            cell.shareItemWidth.constant = self.calculatedShareItemSize.width
            print("********************** Init with width ",cell.itemButton.ts_width)
//            cell.itemButton.ts_height = self.calculatedShareItemSize.height
            cell.shareItemHeight.constant = self.calculatedShareItemSize.height

        }
        return cell
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touchesBegan start")
        
    }
}

// MARK: - @protocol UIScrollViewDelegate
extension TSChatShareMoreView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = self.listCollectionView.ts_width
        self.pageControl.currentPage = Int(self.listCollectionView.contentOffset.x / pageWidth)
    }
}


 // MARK: - @delgate ChatShareMoreViewDelegate
protocol ChatShareMoreViewDelegate: class {
    /**
     选择相册
     */
    func chatShareMoreViewPhotoTaped()
    
    /**
     选择相机
     */
    func chatShareMoreViewCameraTaped()
    
    /**
     TS-006 close the details and send out message
     */
    func chatShareMoreViewMinTab_showShareKeyboard(_ msg:String)
}





