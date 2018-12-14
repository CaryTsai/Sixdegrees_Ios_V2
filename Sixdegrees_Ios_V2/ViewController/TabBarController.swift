//
//  TabBarController.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/10.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var mTabBarItemIndex = UITabBarItem()
    var mTabBarItemVideo = UITabBarItem()
    var mTabBarItemMyKeep = UITabBarItem()
    var mTabBarItemMySetting = UITabBarItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        

    }
    
    
    func initView(){
        
        let tabBarControllerItems = tabBar.items
        let userId = getInt(key: LocalData.USER_ID)

        if let tabArray = tabBarControllerItems {
            mTabBarItemIndex = tabArray[0]
            mTabBarItemVideo = tabArray[1]
            mTabBarItemMyKeep = tabArray[2]
            mTabBarItemMySetting = tabArray[3]
        }


        print("userid",userId)
        
        if(userId != 0){
            
            mTabBarItemMyKeep.isEnabled = true

        }else{
            
            mTabBarItemMyKeep.isEnabled = false

            
        }
        
        
        
    }
        
        // Do any additional setup after loading the view.

    
    
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
//        print("tabbar",item.tag)
//
//        switch item.tag {
//        case 0:
//
//            print("tabbar",item.tag)
//
//        case 1:
//
//            item.isEnabled = false
//            print("tabbar",item.tag)
//
//
//
//        default:
//            print("tabbar",item.tag)
//
//        }
//
//    }


}
