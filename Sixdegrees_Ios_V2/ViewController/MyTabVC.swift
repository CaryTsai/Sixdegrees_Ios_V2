//
//  File.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/26.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import XLPagerTabStrip
import UIKit
import SwiftEventBus



class MyTabVC: ButtonBarPagerTabStripViewController {


    @IBOutlet weak var mButtonBar: UIView!
    @IBOutlet weak var mSearchBar: UIView!
    
    
  
    
    override func viewDidLoad() {
        setButtonBarStyle()
        initView()
        super.viewDidLoad()
            

        
    }
    
    func initView(){
        
        
        mSearchBar.layer.cornerRadius = 15
        mButtonBar.layer.shadowOpacity = 0.2
        mButtonBar.layer.shadowOffset = CGSize.init(width: 0, height: 5)

    }
    
    
    func setButtonBarStyle(){
        
        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 15)
        self.settings.style.buttonBarMinimumInteritemSpacing = 12
        self.settings.style.buttonBarMinimumLineSpacing = 12
        self.settings.style.buttonBarRightContentInset = 50
        self.settings.style.buttonBarLeftContentInset = 0
        self.settings.style.buttonBarItemTitleColor = UIColor.ColorBlue()
        self.settings.style.buttonBarHeight = 45
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarHeight = 0
        
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            
            oldCell?.label.textColor = .lightGray
            newCell?.label.textColor = UIColor.mollyBlueBackgoundColor()
            
        }
        
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    
        
        let tab1 = UIStoryboard(name: LocalData.LOGIN_AFTER, bundle: nil).instantiateViewController(withIdentifier: LocalData.RECOMMEND_TABLEVIEW_VC) as! RecommendTableViewVC
        
        let tab2 = UIStoryboard(name: LocalData.LOGIN_AFTER, bundle: nil).instantiateViewController(withIdentifier: LocalData.POPULAR_TABLEVIEW_VC)  as! PopularTableViewControllerVC

        var List = [tab2,tab1]
        


        for i in 2...ModelConfig.mCategory.count - 1 {
            
            let newsList = UIStoryboard(name: LocalData.LOGIN_AFTER, bundle: nil).instantiateViewController(withIdentifier: LocalData.NEWLIST_TABLEVIEW_VC) as! NewsListTableViewControllerVC
            
            newsList.mTabName.title = ModelConfig.mCategory[i].name
            newsList.mTabId = ModelConfig.mCategory[i].id ?? 0
            
            List.append(newsList)
            
        
        }
        

        return List
    }
    

}
