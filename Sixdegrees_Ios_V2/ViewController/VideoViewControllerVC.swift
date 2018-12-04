//
//  VideoViewController.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/4.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class VideoViewControllerVC: BaseUiViewController,UITableViewDataSource,UITableViewDelegate {

    var mToken = ""
    var mArticle = [Article]()

    @IBOutlet weak var mTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if(getString(key: LocalData.ACCESS_TOKEN) == ""){
            
            mToken = ApiService.bearer+getString(key: LocalData.CLIENT_TOKEN)
            
        }else{
            
            mToken = ApiService.bearer+getString(key: LocalData.ACCESS_TOKEN)
            
        }
        initView()


    }
    
    func initView(){
        
        mTableView.dataSource = self
        mTableView.delegate = self
        
        let nibHeader = UINib(nibName: "VideoTableViewCell", bundle: nil)
        mTableView.register(nibHeader, forCellReuseIdentifier: "VideoTableViewCell")
        mTableView.tableFooterView = UIView()
        getPopularArticleList()

        
    }
    
    
    
    
    
    func getPopularArticleList(){
        

        
//        mActivityBar.isHidden = false
        Callback.mSharedInstance.fetchVideoList(page:1,limit: 100,accesstoken: mToken) { (Article,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
//                self.mActivityBar.isHidden = true
                
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
//                    self.mActivityBar.isHidden = true
                    
                    
                }
                
            default:
                print("與伺服器連線中斷")
//                self.mActivityBar.isHidden = true
                //                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
            
            
        }
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mArticle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let videoUrl:String = mArticle[indexPath.row].news_url
        let videoId = videoUrl.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
        
        
        print("videoUrl",videoId)
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        
        cell.mYoutubePlayer.loadVideoID(videoId)
        

        
        return cell
        
    }
    

}
