//
//  TSStoryViewController.swift
//  TSWeChat
//
//  Created by MT on 20/Dec/16.
//

import UIKit

class TSStoryViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    
    //ts-003 For the function version , story
    fileprivate let itemDataSouce: [[(name: String, iconImage: UIImage)]] = [
        [
            ("1.遗失", TSAsset.Ff_IconQRCode.image),
            ("2.新世界", TSAsset.Ff_IconQRCode.image),
            ("3.行尸走肉", TSAsset.Ff_IconQRCode.image),
            ("4.困", TSAsset.TS_IconThink2.image),
            ("5.遗失", TSAsset.Ff_IconQRCode.image),
            ("6.新世界", TSAsset.Ff_IconQRCode.image),
            ("7.行尸走肉", TSAsset.Ff_IconQRCode.image),
            ("8.困", TSAsset.TS_IconThink2.image),
            ("9.遗失", TSAsset.Ff_IconQRCode.image),
            ("10.新世界", TSAsset.Ff_IconQRCode.image),
            ("11.行尸走肉", TSAsset.Ff_IconQRCode.image),
            ("12.困", TSAsset.TS_IconThink2.image),
            ("13.遗失", TSAsset.Ff_IconQRCode.image),
            ("14.新世界", TSAsset.Ff_IconQRCode.image),
            ("15.行尸走肉", TSAsset.Ff_IconQRCode.image),
            ("16.困", TSAsset.TS_IconThink2.image),
            ("17.遗失", TSAsset.Ff_IconQRCode.image),
            ("18.新世界", TSAsset.Ff_IconQRCode.image),
            ("19.行尸走肉", TSAsset.Ff_IconQRCode.image),
            ("20.困", TSAsset.TS_IconThink2.image),
            ("21.遗失", TSAsset.Ff_IconQRCode.image),
            ("22.新世界", TSAsset.Ff_IconQRCode.image),
            ("23.行尸走肉", TSAsset.Ff_IconQRCode.image),
            ("24.困", TSAsset.TS_IconThink2.image),
            ("25.遗失", TSAsset.Ff_IconQRCode.image),
            ("26.新世界", TSAsset.Ff_IconQRCode.image),
            ("27.行尸走肉", TSAsset.Ff_IconQRCode.image),
            ("28.困", TSAsset.TS_IconThink2.image),
            
        ],
    ]
    var selectedCellIndexPath:IndexPath!
    
    //ts-003 For the function version , story end
    
    override func viewDidLoad() {
        print(" -------- 1 ------ story detail ")
        super.viewDidLoad()
        //ts-001 story

        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.listTableView.ts_registerCellNib(TSStoryTableViewCell.self)
        self.listTableView.estimatedRowHeight = 44
        self.listTableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
        log.verbose("deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: @protocol - UITableViewDelegate
extension TSStoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print(" -------- 3 ------ story detail heightForHeaderInSection")
        if section == 0 {
            return 15
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        print(" -------- 3.1 ------ story detail heightForFooterInSection")
        return 0.00001
    }
    

    //select row !!!  working on
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(" -------- 3.2 ------ story detail didSelectRowAt")
        tableView.deselectRow(at: indexPath, animated: true)
        print(" chicked indexPath : ",indexPath)
        
        //deselect
        self.listTableView!.deselectRow(at: indexPath, animated: false)
        
        if(selectedCellIndexPath != nil && selectedCellIndexPath == indexPath){
            print("$$$ close opened story ",indexPath)
            selectedCellIndexPath = nil
            
            let cellT:TSStoryTableViewCell = self.listTableView!.cellForRow(at: indexPath) as! TSStoryTableViewCell
            cellT.thinkBtn.isHidden = true
            
            self.listTableView!.reloadData()
            return
        }else{
            print("$$$ opening story ",indexPath)
            //[BUG TO FIX]: scroll to row didn't work when the bottem don't have enough rows
            
            //store global
            selectedCellIndexPath = indexPath
            //forces the table view to call heightForRowAtIndexPath
            self.listTableView!.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                let numberOfRows = indexPath.row
                if numberOfRows > 0 {
                    self.listTableView!.scrollToRow(at: indexPath, at: .top, animated: true)
                }
            }
            
            let cellT:TSStoryTableViewCell = self.listTableView!.cellForRow(at: indexPath) as! TSStoryTableViewCell
            cellT.thinkBtn.isHidden = false

            return
        }

    }
}

// MARK: @protocol - UITableViewDataSource
extension TSStoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {   //define rows
        print(" -------- 4.1 ------ story detail numberOfSections")
        return self.itemDataSouce.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(" -------- 4.2 ------ story detail numberOfRowsInSection")
        let rows = self.itemDataSouce[section]
        return rows.count
    }
    
    //from forces the table view didSelectRowAt !!! working on
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(" -------- 4.3 ------ story detail heightForRowAt")
        
        //[BUG TO FIX]: hardcode value need to be replaced
        var out = 50
        if(selectedCellIndexPath != nil && selectedCellIndexPath == indexPath){
            out = 480
            let cell:TSStoryTableViewCell = tableView.cellForRow(at: indexPath) as! TSStoryTableViewCell
            
            print(" @@@@@@@@@@@@@@@ ")
            print(cell.cellTextView.height)
            print(" @@@@@@@@@@@@@@@ ")

        }
        print(" cal height indexPath : ",indexPath, " ",out)
        return CGFloat(out)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(" -------- 4.4 ------ story detail cellForRowAt")

        let cell :TSStoryTableViewCell = tableView.ts_dequeueReusableCell(TSStoryTableViewCell.self)
        let item = self.itemDataSouce[indexPath.section][indexPath.row]
        //cell.testImage.image = item.iconImage
        cell.testLabel.text = item.name
        cell.thinkBtn.setImage(item.iconImage, for: .normal)
        
//        cell.thinkBtn.addTarget(self, action: Selector(("btnTouched:")), for: .touchUpInside)

        return cell
    }
}



