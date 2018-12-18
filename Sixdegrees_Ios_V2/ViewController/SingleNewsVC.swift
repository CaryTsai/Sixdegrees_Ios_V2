//
//  NewsVC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/13.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SDWebImage



class SingleNewsVC: BaseUiViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var mTableView: UITableView!
    
    var mToken:String = ""
    var mNewsId=Int()
    var mNewsData = [ArticleDetail]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

        // Do any additional setup after loading the view.
    }
    
    
    func initView(){
        
        print("NewsId",mNewsId)

        if(getString(key: LocalData.ACCESS_TOKEN) != ""){
            
            mToken = ApiService.bearer+getString(key: LocalData.ACCESS_TOKEN)
            getUserKeepList()
            
        }else{
            
            mToken = ApiService.bearer+getString(key: LocalData.CLIENT_TOKEN)
                getUserKeepList()
            
        }
        
        self.mTableView.register(UINib(nibName: "SingleNewsImageTVC", bundle: nil), forCellReuseIdentifier: "SingleNewsImageTVC")
        self.mTableView.register(UINib(nibName: "SingNewsMessage", bundle: nil), forCellReuseIdentifier: "SingNewsMessage")
        self.mTableView.register(UINib(nibName: "GoogleAdsTVC", bundle: nil), forCellReuseIdentifier: "GoogleAdsTVC")
        self.mTableView.register(UINib(nibName: "SIngNewsHotTVC", bundle: nil), forCellReuseIdentifier: "SIngNewsHotTVC")
        self.mTableView.tableFooterView = UIView()
        self.mTableView.separatorColor = UIColor.clear
        



        
        
    }
    
    func getUserKeepList(){
        
        mTableView.isHidden = true
        Callback.mSharedInstance.fetchArticle(accesstoken:mToken,articleId: String(mNewsId)) { (ArticleDetail,code,error) in
            
            if let error = error{
                print("網路連線不良",error)

                self.mTableView.isHidden = true
                
                
                //                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            switch code {
            case 200,201:
                
                if(ArticleDetail != nil){
                    
                    guard let getArticleDetail = ArticleDetail else { return }
//                    print("ArticleDetail",getArticleDetail)
                    self.mNewsData = [getArticleDetail]
                    print("ArticleDetail",self.mNewsData[0])
                    self.mTableView.reloadData()
                    self.mTableView.isHidden = false
                    self.mTableView.dataSource = self
                    self.mTableView.delegate = self
          
                    
                    
                    
                }else{
                    
                    
                    
                }
                
            default:
                print("與伺服器連線中斷")
                self.mTableView.isHidden = true
                
                //                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mNewsData[0].comment_total+7
    }
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 15
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Time = (getNowTimestamp() - ModelConfig.mArticle[indexPath.row].report_time) / 60 / 60

        
        switch indexPath.item {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleNewsImageTVC", for: indexPath) as! SingleNewsImageTVC
        
            if (Time <= 0) {
                cell.mSingNewsTime.setTitle("剛剛", for: .normal)
            } else {
                cell.mSingNewsTime.setTitle(String(lroundf(Float(Time)))+"小時前",for: .normal)
            }
            
            if (Time >= 24) {
                
                let timehr = Time/24
                cell.mSingNewsTime.setTitle(String(lroundf(Float(timehr)))+"天前",for: .normal)
                
            }
            
            cell.mSingNewsTitleLb.text = mNewsData[0].title
            cell.mSingNewsInnerLb.text = mNewsData[0].description
            cell.mSingNewsSourceBt.setTitle(mNewsData[0].datasource_name, for: .normal)
            cell.mSingNewsPageViewBt.setTitle(String(mNewsData[0].pageview), for: .normal)
            cell.mSingNewsIv.sd_setImage(with: URL(string: (mNewsData[0].media?[0].small ?? "")),placeholderImage: UIImage(named: "image_null_tw"))



            return cell
        case 1,7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleAdsTVC", for: indexPath) as! GoogleAdsTVC
            cell.mGoogleAdsView.rootViewController = self
            return cell
        case 2,3,4,5,6:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SIngNewsHotTVC", for: indexPath) as! SIngNewsHotTVC
       
            
            for i in 0...5 {
                
                if indexPath.item == i+2{
                    
                    cell.mHotLb.text = mNewsData[0].latest?[i].title
                    cell.mHotIv.sd_setImage(with: URL(string: (mNewsData[0].latest?[i].media?.small ?? "")),placeholderImage: UIImage(named: "image_null_tw"))


                    
                }
            }
            
//            if(indexPath.item == 2){
//
//                cell.mHotLb.text = mNewsData[0].latest?[0].title
//
//
//            }else if indexPath.item == 3{
//
//                cell.mHotLb.text = mNewsData[0].latest?[1].title
//
//            }else if indexPath.item == 4{
//
//                cell.mHotLb.text = mNewsData[0].latest?[2].title
//
//
//            }else if indexPath.item == 5{
//
//                cell.mHotLb.text = mNewsData[0].latest?[3].title
//
//            }else if indexPath.item == 6{
//
//                cell.mHotLb.text = mNewsData[0].latest?[4].title
//
//
//            }
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingNewsMessage", for: indexPath) as! SingNewsMessage
            return cell
            
        }
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("dsdsds")
    }


}
