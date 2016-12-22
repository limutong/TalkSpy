//
//  TSDiscoverViewController.swift
//  TSWeChat
//
//  Created  by Hilen on 1/8/16.
//  Modified by MT
//

import UIKit

class TSDiscoverViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    //ts-003 For the function version , story
    fileprivate let itemDataSouce: [[(name: String, iconImage: UIImage)]] = [
        [
            ("回忆篇", TSAsset.Ff_IconShowAlbum.image),
            ("现在篇", TSAsset.MoreGame.image),
            ("N的调查报告", TSAsset.Ff_IconQRCode.image),
        ],
        [
            ("每个人的故事", TSAsset.Ff_IconBottle.image),
        ],
    ]
    //ts-003 For the function version , story end
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //ts-001 story
        self.title = "故事"
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.listTableView.ts_registerCellNib(TSImageTextTableViewCell.self)
        self.listTableView.estimatedRowHeight = 44
        self.listTableView.tableFooterView = UIView()

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
extension TSDiscoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                print(" -------- 3 ------ story main heightForHeaderInSection")
        if section == 0 {
            return 15
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        print(" -------- 3.1 ------ story main heightForFooterInSection")
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(" -------- 3.2 ------ story main didSelectRowAt")
        tableView.deselectRow(at: indexPath, animated: true)
        
        print(" story main chicked indexPath : ",indexPath)

        //init story new page
        let controllerY = TSStoryViewController.ts_initFromNib()
        
        print (itemDataSouce[indexPath.section][indexPath.row].name)
        //set title
        controllerY.title = itemDataSouce[indexPath.section][indexPath.row].name

        //fire
        navigationController?.pushViewController(controllerY, animated: true)
    }
}

// MARK: @protocol - UITableViewDataSource
extension TSDiscoverViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {   //define rows
        print(" -------- 4.1 ------ story main numberOfSections")
        return self.itemDataSouce.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(" -------- 4.2 ------ story main numberOfRowsInSection")
        let rows = self.itemDataSouce[section]
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(" -------- 4.3 ------ story main heightForRowAt ",self.listTableView.estimatedRowHeight)
        return self.listTableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(" -------- 4.4 ------ story main cellForRowAt")
        let cell :TSImageTextTableViewCell = tableView.ts_dequeueReusableCell(TSImageTextTableViewCell.self)
        let item = self.itemDataSouce[indexPath.section][indexPath.row]
        cell.iconImageView.image = item.iconImage
        cell.titleLabel.text = item.name
        return cell
    }
}



