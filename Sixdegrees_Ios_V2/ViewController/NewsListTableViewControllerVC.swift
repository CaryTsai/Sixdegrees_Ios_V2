//
//  NewsListTableViewController.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/3.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage
import SwiftEventBus


class NewsListTableViewControllerVC: BaseUiViewController,UITableViewDataSource,UITableViewDelegate {
    
    var mTabId:Int = 0
    var mTabName:IndicatorInfo = ""
    var mToken = ""
    var mArticle = [Article]()
    var mAdsCount = 0

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mActivityBar: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        if(getString(key: LocalData.ACCESS_TOKEN) == ""){
            
            mToken = ApiService.bearer+getString(key: LocalData.CLIENT_TOKEN)
            
        }else{
            
            mToken = ApiService.bearer+getString(key: LocalData.ACCESS_TOKEN)
            
        }
        
        getTagArticleList()
        
        
        
        
    }
    
    
    
    func initView(){
        



        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.isHidden = true
        mActivityBar.startAnimating()
   

        let nibHeader = UINib(nibName:LocalData.NEWS_HEADER_TABLEVIEW_CELL, bundle: nil)
        mTableView.register(nibHeader, forCellReuseIdentifier: LocalData.NEWS_HEADER_TABLEVIEW_CELL)
        mTableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: LocalData.NEWS_TABLEVIEW_CELL, bundle: nil)
        mTableView.register(nib, forCellReuseIdentifier: LocalData.NEWS_TABLEVIEW_CELL)
        mTableView.register(UINib(nibName: "GoogleAdsTVC", bundle: nil), forCellReuseIdentifier: "GoogleAdsTVC")
        mTableView.tableFooterView = UIView()
        mTableView.separatorColor = UIColor.clear
    
    }
    
    func getTagArticleList(){
        
        let tabid = String(mTabId)
        print(tabid)
        mActivityBar.isHidden = false
        Callback.mSharedInstance.fetchTagArticleList(tagId:tabid,page:1,accesstoken:mToken) { (Article,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
//                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "網路連線不良")
                self.mActivityBar.isHidden = true
                return
            }
            switch code {
            case 200,201:
                
                if(Article != nil){
                    
                    guard let getArticle = Article else { return }
               
                    self.mArticle = getArticle
                    print(self.mArticle)
                    self.mTableView.reloadData()
                    self.mTableView.isHidden = false
                    self.mActivityBar.isHidden = false
                    self.mAdsCount = self.mArticle.count/5
                    print("mAdsCount",self.mAdsCount)

                    
                    
                }
                
            default:
                print("與伺服器連線中斷")
//                self.dismiss(animated: true, completion: nil)
//                self.setSnackbar(mseeage: "與伺服器連線中斷")
                self.mActivityBar.isHidden = true

            }
            
            
        }
        
        
    }
    
    

    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print( "一一一一",mArticle.count )

        return mArticle.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Time = (getNowTimestamp() - mArticle[indexPath.row].report_time) / 60 / 60
        print(Time)

        
        if(indexPath.item % 5 == 0 ){
            
            let cell = tableView.dequeueReusableCell(withIdentifier:LocalData.NEWS_HEADER_TABLEVIEW_CELL, for: indexPath) as! NewsHeaderTableViewCell
            
            
            if (Time <= 0) {
                cell.mRecommendCellTimeButton.setTitle("剛剛", for: .normal)
            } else {
                cell.mRecommendCellTimeButton.setTitle(String(lroundf(Float(Time)))+"小時前",for: .normal)
            }
            
            if (Time >= 24) {
                
                let timehr = Time/24
                cell.mRecommendCellTimeButton.setTitle(String(lroundf(Float(timehr)))+"天前",for: .normal)
                
            }
            cell.mRecommendCellImageView.sd_setImage(with: URL(string: (mArticle[indexPath.row].media?.small ?? "")),placeholderImage: UIImage(named: LocalData.IMAGE_NULL_TW))
            
            
            cell.mRecommendCellTitleLabel.text = mArticle[indexPath.row].title
            cell.mRecommendCellSourceButton.setTitle(mArticle[indexPath.row].datasource_name, for: .normal)
            cell.mRecommendViewButton.setTitle(String(mArticle[indexPath.row].pageview), for: .normal)
            return cell
            
        }else if indexPath.item % 5 == 4{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleAdsTVC", for: indexPath) as! GoogleAdsTVC
            cell.mGoogleAdsView.rootViewController = self
            return cell
            
        }else{
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "SingleNews", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SingleNews") as! SingleNewsVC
        initialViewController.mNewsId = mArticle[indexPath.row].id
        present(initialViewController, animated: true, completion: nil)
        
    }
    
}

extension NewsListTableViewControllerVC:IndicatorInfoProvider{

    func indicatorInfo(for pagerTabStripViewController:PagerTabStripViewController) ->IndicatorInfo{

        return  mTabName

    }
}
    



