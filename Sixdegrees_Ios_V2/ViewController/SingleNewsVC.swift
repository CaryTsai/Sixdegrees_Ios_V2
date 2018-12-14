//
//  NewsVC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/13.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import GoogleMobileAds


class SingleNewsVC: BaseUiViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var mTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

        // Do any additional setup after loading the view.
    }
    
    
    func initView(){
        
        let userId = getInt(key: LocalData.USER_ID)
        
        
        if userId == 0{
            
 
            
        }else{
            

        }
        
        
        mTableView.dataSource = self
        mTableView.delegate = self
//        self.mTableView.isScrollEnabled = false
        
//        let nibHeader = UINib(nibName: "SingleNewsImageTVC", bundle: nil)
        mTableView.register(UINib(nibName: "SingleNewsImageTVC", bundle: nil), forCellReuseIdentifier: "SingleNewsImageTVC")
        mTableView.register(UINib(nibName: "SingNewsInnerTVC", bundle: nil), forCellReuseIdentifier: "SingNewsInnerTVC")
        mTableView.register(UINib(nibName: "GoogleAdsTVC", bundle: nil), forCellReuseIdentifier: "GoogleAdsTVC")
        mTableView.register(UINib(nibName: "SIngNewsHotTVC", bundle: nil), forCellReuseIdentifier: "SIngNewsHotTVC")



        mTableView.tableFooterView = UIView()
        mTableView.separatorColor = UIColor.clear
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        switch indexPath.item {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleNewsImageTVC", for: indexPath) as! SingleNewsImageTVC
            
            return cell

        case 1:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingNewsInnerTVC", for: indexPath) as! SingNewsInnerTVC
            
            return cell
            
        case 2:
                
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleAdsTVC", for: indexPath) as! GoogleAdsTVC
            cell.mGoogleAdsView.rootViewController = self
            return cell

        default:

            let cell = tableView.dequeueReusableCell(withIdentifier: "SIngNewsHotTVC", for: indexPath) as! SIngNewsHotTVC

            return cell


        }
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("dsdsds")
    }
    
    
    func setGoogleAds(){
        


        
    }


}
