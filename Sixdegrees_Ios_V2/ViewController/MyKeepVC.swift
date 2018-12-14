//
//  MyKeepVC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/7.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage

class MyKeepVC: BaseUiViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mActivityBar: UIActivityIndicatorView!
    var mToken  = ""
    var mUserID = 0
    var mArticle = [Article]()


    override func viewDidLoad() {
        super.viewDidLoad()
        if(getString(key: LocalData.ACCESS_TOKEN) != ""){
            
            mToken = ApiService.bearer+getString(key: LocalData.ACCESS_TOKEN)
            getUserKeepList()
            
        }
        initView()

    }
    
    
    func initView(){
        
        mTableView.dataSource = self
        mTableView.delegate = self
        
        let nibHeader = UINib(nibName: LocalData.NEWS_TABLEVIEW_CELL, bundle: nil)
        mTableView.register(nibHeader, forCellReuseIdentifier: LocalData.NEWS_TABLEVIEW_CELL)
        mTableView.tableFooterView = UIView()
        mTableView.separatorColor = UIColor.clear
        
        
        
    }
    
    
    func getUserKeepList(){
        
        
        print("mToken",mToken)
        print("UserId",mUserID)
        
        mActivityBar.isHidden = false
        mActivityBar.startAnimating()
        mTableView.isHidden = true
        Callback.mSharedInstance.fetchUserKeepList(accessToken:mToken,userId:nil,page:1) { (Article,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
                self.mActivityBar.isHidden = true
                self.mTableView.isHidden = true
                
                
                //                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            switch code {
            case 200,201:
                
                if(Article != nil){
                    
                    guard let getArticle = Article else { return }
                    self.mArticle = getArticle
                    print("喔喔喔喔了解",self.mArticle)
                    self.mTableView.reloadData()
                    self.mActivityBar.isHidden = true
                    self.mTableView.isHidden = false
                    
                    
                    
                }else{
                    
                    self.mActivityBar.isHidden = true

                    
                }
                
            default:
                print("與伺服器連線中斷")
                self.mActivityBar.isHidden = true
                self.mTableView.isHidden = true
                
                //                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
            
            
        }
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mArticle.count

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Time = (getNowTimestamp() - mArticle[indexPath.row].report_time) / 60 / 60
        let cell = tableView.dequeueReusableCell(withIdentifier: LocalData.NEWS_TABLEVIEW_CELL, for: indexPath) as! NewsTableViewCell
        //                let cell = Bundle.main.loadNibNamed("RecommendCell", owner: self, options: nil)?.first as! RecommendCell
        
        if (Time <= 0) {
            cell.mRecommendCellTime.setTitle("剛剛", for: .normal)
        } else {
            cell.mRecommendCellTime.setTitle(String(lroundf(Float(Time)))+"小時前",for: .normal)
        }
        
        if (Time >= 24) {
            
            let timehr = Time/24
            cell.mRecommendCellTime.setTitle(String(lroundf(Float(timehr)))+"天前",for: .normal)
        }
        cell.mRecommendCellImageView.sd_setImage(with: URL(string: mArticle[indexPath.row].media?.small ?? ""), placeholderImage: UIImage(named: LocalData.IMAGE_NULL_TW))
        cell.mRecommendCellTitle.text = mArticle[indexPath.row].title
        cell.mRecommendCellSource.setTitle(mArticle[indexPath.row].datasource_name, for: .normal)
        cell.mRecommendCellPageView.setTitle(String(mArticle[indexPath.row].pageview), for: .normal)
        return cell
        
    }
    

}
