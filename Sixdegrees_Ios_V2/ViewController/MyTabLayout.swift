//
//  File.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/26.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import XLPagerTabStrip
import UIKit


class MyTabLayout: ButtonBarPagerTabStripViewController {


    @IBOutlet weak var mButtonBar: UIView!
    @IBOutlet weak var mSearchBar: UIView!
    
    override func viewDidLoad() {

        mButtonBar.layer.shadowOpacity = 0.1
        mButtonBar.layer.shadowOffset = CGSize(width: 4, height: 6)
        mSearchBar.clipsToBounds = true
        mSearchBar.layer.cornerRadius = 10

        

        self.settings.style.buttonBarItemFont = .systemFont(ofSize: 15)
        //        self.settings.style.ali
        self.settings.style.buttonBarMinimumInteritemSpacing = 12
        self.settings.style.buttonBarMinimumLineSpacing = 12
        self.settings.style.buttonBarRightContentInset = 50
        self.settings.style.buttonBarItemTitleColor = UIColor.blue
        self.settings.style.buttonBarHeight = 45
        self.settings.style.buttonBarBackgroundColor = UIColor.white
        self.settings.style.buttonBarItemBackgroundColor = UIColor.white
        self.settings.style.selectedBarHeight = 0
        //        self.settings.style.selectedBarBackgroundColor = UIColor.NavigationDeepBlue()

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }

            oldCell?.label.textColor = .lightGray
            newCell?.label.textColor = UIColor.blue

            //            if animated {
            //                UIView.animate(withDuration: 0.1, animations: { () -> Void in
            //                    newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            //                    oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            //                })
            //            }
            //            else {
            //                newCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            //                oldCell?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            //            }
        }
        
        super.viewDidLoad()

        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
      let tab1 = UIStoryboard(name: "LoginAfter", bundle: nil).instantiateViewController(withIdentifier: "RecommendTabVC")
        
      let tab2 = UIStoryboard(name: "LoginAfter", bundle: nil).instantiateViewController(withIdentifier: "PopularTableViewVC")

        return [tab2,tab1]
    }

}
