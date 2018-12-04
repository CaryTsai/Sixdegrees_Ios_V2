//
//  PopularTableViewController.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/28.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage


class PopularTableViewControllerVC: BaseUiViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mButtonBar: UIView!
    
    @IBOutlet weak var m24hButton: UIButton!
    @IBOutlet weak var m3dayButton: UIButton!
    @IBOutlet weak var m7dayButton: UIButton!
    @IBOutlet weak var mActivityBar: UIActivityIndicatorView!
    
    
    var mTimeType:String = "24h"
    
    var mToken = ""

    
    
    
    
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
        
        set24hButtonStyle()
        mActivityBar.isHidden = true
        mActivityBar.startAnimating()
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        mTableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        mTableView.tableFooterView = UIView()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.separatorColor = UIColor.clear
        mButtonBar.clipsToBounds = true
        mButtonBar.layer.cornerRadius = 5
        
    }
    

    @IBAction func oneDayAction(_ sender: Any) {
        
        set24hButtonStyle()
        mTimeType = "24h"
        getPopularArticleList(timetype: mTimeType)

        
    }
    
    @IBAction func threeDayAction(_ sender: Any) {
        
        set3dayshButtonStyle()
        mTimeType = "3d"
        getPopularArticleList(timetype: mTimeType)
        
    }
    
    @IBAction func weekAction(_ sender: Any) {
        
        set7dayshButtonStyle()
        mTimeType = "1w"
        getPopularArticleList(timetype: mTimeType)

    }
    
    
    func getPopularArticleList(timetype:String){
        
        
     mActivityBar.isHidden = false
     Callback.mSharedInstance.fetchPopularArticleList(accesstoken: mToken,page:1,limit:20,timetype:timetype) { (Article,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
                self.mActivityBar.isHidden = true

//                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            switch code {
            case 200,201:
                
                if(Article != nil){
                    
                    guard let getArticle = Article else { return }
                    ModelConfig.mPopularArticle = getArticle
                    print("喔喔喔喔了解",ModelConfig.mPopularArticle)
                    self.mTableView.reloadData()
                    self.mActivityBar.isHidden = true
                    
                    
                }
                
            default:
                print("與伺服器連線中斷")
                self.mActivityBar.isHidden = true
//                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
            
            
        }
        
        
    }
    
    
    
    func set24hButtonStyle(){
        
        m24hButton.backgroundColor = UIColor.ColorBlue()
        m24hButton.setTitleColor(UIColor.white,for:.normal)
        m24hButton.layer.cornerRadius = 5
        m24hButton.setImage(UIImage(named: LocalData.POPULAR_24_HOURS), for: .normal)
        
        m3dayButton.backgroundColor = UIColor.ColorLightBlue()
        m3dayButton.setTitleColor(UIColor.ColorBlue(),for:.normal)
        m3dayButton.layer.cornerRadius = 0
        m3dayButton.setImage(UIImage(named: LocalData.POPULAR_3_DAYS_UNCLICK), for: .normal)
        
        m7dayButton.backgroundColor = UIColor.ColorLightBlue()
        m7dayButton.setTitleColor(UIColor.ColorBlue(),for:.normal)
        m7dayButton.layer.cornerRadius = 0
        m7dayButton.setImage(UIImage(named: LocalData.POPULAR_7_DAYS_UNCLICK), for: .normal)
    }
    
    func set3dayshButtonStyle(){
        
        m3dayButton.backgroundColor = UIColor.ColorBlue()
        m3dayButton.setTitleColor(UIColor.white,for:.normal)
        m3dayButton.layer.cornerRadius = 5
        m3dayButton.setImage(UIImage(named: LocalData.POPULAR_3_DAYS), for: .normal)
        
        m24hButton.backgroundColor = UIColor.ColorLightBlue()
        m24hButton.setTitleColor(UIColor.ColorBlue(),for:.normal)
        m24hButton.layer.cornerRadius = 0
        m24hButton.setImage(UIImage(named: LocalData.POPULAR_24_HOURS_UNCLICK), for: .normal)
        
        m7dayButton.backgroundColor = UIColor.ColorLightBlue()
        m7dayButton.setTitleColor(UIColor.ColorBlue(),for:.normal)
        m7dayButton.layer.cornerRadius = 0
        m7dayButton.setImage(UIImage(named: LocalData.POPULAR_7_DAYS_UNCLICK), for: .normal)
    }
    
    func set7dayshButtonStyle(){
        
        m7dayButton.backgroundColor = UIColor.ColorBlue()
        m7dayButton.setTitleColor(UIColor.white,for:.normal)
        m7dayButton.layer.cornerRadius = 5
        m7dayButton.setImage(UIImage(named: LocalData.POPULAR_7_DAYS), for: .normal)
        
        m24hButton.backgroundColor = UIColor.ColorLightBlue()
        m24hButton.setTitleColor(UIColor.ColorBlue(),for:.normal)
        m24hButton.layer.cornerRadius = 0
        m24hButton.setImage(UIImage(named: LocalData.POPULAR_24_HOURS_UNCLICK), for: .normal)
        
        m3dayButton.backgroundColor = UIColor.ColorLightBlue()
        m3dayButton.setTitleColor(UIColor.ColorBlue(),for:.normal)
        m3dayButton.layer.cornerRadius = 0
        m3dayButton.setImage(UIImage(named: LocalData.POPULAR_3_DAYS_UNCLICK), for: .normal)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ModelConfig.mPopularArticle.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Time = (getNowTimestamp() - ModelConfig.mPopularArticle[indexPath.row].report_time) / 60 / 60
        print(Time)
        
        let cellIdentifier = "NewsTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath ) as! NewsTableViewCell
        
        if (Time <= 0) {
            cell.mRecommendCellTime.setTitle("剛剛", for: .normal)
        } else {
            cell.mRecommendCellTime.setTitle(String(lroundf(Float(Time)))+"小時前",for: .normal)
        }
        
        if (Time >= 24) {
            
            let timehr = Time/24
            cell.mRecommendCellTime.setTitle(String(lroundf(Float(timehr)))+"天前",for: .normal)
        }
        cell.mRecommendCellImageView.sd_setImage(with: URL(string: ModelConfig.mPopularArticle[indexPath.row].media?.small ?? ""), placeholderImage: UIImage(named: "image_null_tw"))
        cell.mRecommendCellTitle.text = ModelConfig.mPopularArticle[indexPath.row].title
        cell.mRecommendCellSource.setTitle(ModelConfig.mPopularArticle[indexPath.row].datasource_name, for: .normal)
        cell.mRecommendCellPageView.setTitle(String(ModelConfig.mPopularArticle[indexPath.row].pageview), for: .normal)
        return cell
        
    }
    
}

extension PopularTableViewControllerVC:IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripViewController:PagerTabStripViewController) ->IndicatorInfo{
        
        return IndicatorInfo(title: ModelConfig.mCategory[1].name)
        
    }
    
}
