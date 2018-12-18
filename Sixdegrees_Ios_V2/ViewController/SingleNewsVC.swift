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
    var abc = ""

    
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
        
        return (mNewsData[0].comment?.data?.count)!+(mNewsData[0].latest?.count)! + 3
    }
    
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 15
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Time = (getNowTimestamp() - mNewsData[0].report_time) / 60 / 60

        
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

            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingNewsMessage", for: indexPath) as! SingNewsMessage
            
            for i in 0...(mNewsData[0].comment?.data?.count)! - 1 {
                
                if indexPath.item == i+8{
                    let Time = (getNowTimestamp() - (mNewsData[0].comment?.data?[i].create_time)!) / 60 / 60
                    
                    if (Time <= 0) {
                        cell.mMessageTime.text = "剛剛"
                    } else {
                        cell.mMessageTime.text = (String(lroundf(Float(Time)))+"小時前")
                    }
                    
                    if (Time >= 24) {
                        
                        let timehr = Time/24
                        cell.mMessageTime.text = (String(lroundf(Float(timehr)))+"天前")
                        
                    }
                    cell.mMessageBt.tag = i
                    cell.mMessageNameLb.text = mNewsData[0].comment?.data?[i].user_name
                    cell.mMessageLb.text = mNewsData[0].comment?.data?[i].text
                    cell.mMessageLinkLb.text = String(mNewsData[0].comment?.data?[i].like_total ?? 0)
                    cell.mMessageBt.setTitle("回覆 " + String(mNewsData[0].comment?.data?[i].comment_total ?? 0), for: .normal)
                    cell.mMessagePhotoIV.sd_setImage(with: URL(string: (mNewsData[0].comment?.data?[i].user_avatar ?? "")),placeholderImage: UIImage(named: "avatar_initial"))
                    cell.mMessageBt.addTarget(self, action: #selector(MessageBt(_:)), for: .touchDown)


                    
                }
                


                
            }
            
            
            
            
            
            return cell
            
        }
        
        
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
    }
    
    
    @objc func MessageBt(_ messageBt:UIButton) {

        print("喔喔喔",(mNewsData[0].comment?.data?[messageBt.tag].comment_url) ?? "")
  
    }


}
