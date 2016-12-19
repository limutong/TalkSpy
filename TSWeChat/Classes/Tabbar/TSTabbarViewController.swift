//
//  TSTabbarViewController.swift
//  Talk Spy Main Page
//
//  By MT on 16 Dec 19.
//  Version 1.0.0
//

import UIKit
import TimedSilver

class TSTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
    }
    
    func setupViewController() {
        //ts-001 story
        let titleArray = ["微信", "通讯录", "故事", "我"]
        
        let normalImagesArray = [
            TSAsset.Tabbar_mainframe.image,             //mainframe is the chat (message)
            TSAsset.Tabbar_contacts.image,
            TSAsset.Tabbar_discover.image,
            TSAsset.Tabbar_me.image,
        ]
        
        let selectedImagesArray = [
            TSAsset.Tabbar_mainframeHL.image,
            TSAsset.Tabbar_contactsHL.image,
            TSAsset.Tabbar_discoverHL.image,
            TSAsset.Tabbar_meHL.image,
        ]
        
        let viewControllerArray = [
            TSMessageViewController.ts_initFromNib(),   //微信
            TSContactsViewController.ts_initFromNib(),  //通讯录
            TSDiscoverViewController.ts_initFromNib(),  //故事
            TSMeViewController.ts_initFromNib()         //我
        ]
        
        let navigationVCArray = NSMutableArray()
        for (index, controller) in viewControllerArray.enumerated() {
            controller.tabBarItem!.title = titleArray.get(index: index)                                                         //set title
            controller.tabBarItem!.image = normalImagesArray.get(index: index).withRenderingMode(.alwaysOriginal)               //set image
            controller.tabBarItem!.selectedImage = selectedImagesArray.get(index: index).withRenderingMode(.alwaysOriginal)     //set image
            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGray], for: UIControlState())
            controller.tabBarItem!.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.tabbarSelectedTextColor], for: .selected)
            let navigationController = UINavigationController(rootViewController: controller)               //create nv container for each crl
            navigationVCArray.add(navigationController)
        }
        self.viewControllers = navigationVCArray.mutableCopy() as! [UINavigationController]                 //View ++> Nav --> viewControllers => Linked
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
