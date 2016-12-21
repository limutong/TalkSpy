//
//  TSStoryViewController.swift
//  TSWeChat
//
//  Created by  MT on 20/Dec/16.
//

import UIKit

class TSStoryViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    //ts-003 For the function version , story
    fileprivate let itemDataSouce: [[(name: String, iconImage: UIImage)]] = [
        [
            ("xxx", TSAsset.Ff_IconShowAlbum.image),
            ("yyy", TSAsset.MoreGame.image),
            ("zzz", TSAsset.Ff_IconQRCode.image),
            ],
        [
            ("ttt", TSAsset.Ff_IconBottle.image),
            ],
        ]
    //ts-003 For the function version , story end
    override func viewDidLoad() {
        print(" -------- 1 ------ ")
        super.viewDidLoad()
        //ts-001 story
        self.title = "Story Details"
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.listTableView.ts_registerCellNib(TSImageTextTableViewCell.self)
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

// MARK: @protocol - UITableViewDelegate
extension TSStoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        print(" -------- 3 ------ ")
        if section == 0 {
            return 15
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        print(" -------- 3.1 ------ ")
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(" -------- 3.2 ------ ")
        tableView.deselectRow(at: indexPath, animated: true)
        print(" chicked indexPath : ",indexPath)
        
        //init from a inb with same name of the class, return UIViewController
        let controllerX = TSContactsViewController.ts_initFromNib()  //通讯录
        controllerX.tabBarItem!.title = "Story Details"  //set title
        controllerX.tabBarItem!.image = TSAsset.Tabbar_mainframe.image //set image
        controllerX.tabBarItem!.selectedImage = TSAsset.Tabbar_mainframeHL.image.withRenderingMode(.alwaysOriginal)     //set image
        controllerX.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGray], for: UIControlState())
        controllerX.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.tabbarSelectedTextColor], for: .selected)
        
        //fire
        navigationController?.pushViewController(controllerX, animated: true)
    }
}

// MARK: @protocol - UITableViewDataSource
extension TSStoryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {   //define rows
        print(" -------- 4.1 ------ ")
        return self.itemDataSouce.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(" -------- 4.2 ------ ")
        let rows = self.itemDataSouce[section]
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(" -------- 4.3 ------ ")
        return self.listTableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(" -------- 4.4 ------ ")
        let cell :TSImageTextTableViewCell = tableView.ts_dequeueReusableCell(TSImageTextTableViewCell.self)
        let item = self.itemDataSouce[indexPath.section][indexPath.row]
        cell.iconImageView.image = item.iconImage
        cell.titleLabel.text = item.name
        return cell
    }
}



