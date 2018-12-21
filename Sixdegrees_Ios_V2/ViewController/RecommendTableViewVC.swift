//
//  TableViewControllerOne.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/26.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SDWebImage


class RecommendTableViewVC: BaseUiViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var mTableView: UITableView!
    
    var mAdsCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mTableView.register(UINib(nibName: "NewsHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsHeaderTableViewCell")
        mTableView.register(UINib(nibName: "GoogleAdsTVC", bundle: nil), forCellReuseIdentifier: "GoogleAdsTVC")

        mAdsCount = ModelConfig.mArticle.count/5
        mTableView.tableFooterView = UIView()
        
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        mTableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.tableFooterView = UIView()
        mTableView.separatorColor = UIColor.clear



    }

    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        print( "一一一一",ModelConfig.mArticle.count + mAdsCount)
        return ModelConfig.mArticle.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Time = (getNowTimestamp() - ModelConfig.mArticle[indexPath.row].report_time) / 60 / 60
        print(Time)

            if(indexPath.item % 5 == 0){
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsHeaderTableViewCell", for: indexPath) as! NewsHeaderTableViewCell
                
                
                if (Time <= 0) {
                    cell.mRecommendCellTimeButton.setTitle("剛剛", for: .normal)
                } else {
                    cell.mRecommendCellTimeButton.setTitle(String(lroundf(Float(Time)))+"小時前",for: .normal)
                }
                
                if (Time >= 24) {
       
                    let timehr = Time/24
                    cell.mRecommendCellTimeButton.setTitle(String(lroundf(Float(timehr)))+"天前",for: .normal)

                }
                cell.mRecommendCellImageView.sd_setImage(with: URL(string: (ModelConfig.mArticle[indexPath.row].media?.small ?? "")),placeholderImage: UIImage(named: "image_null_tw"))

                
                cell.mRecommendCellTitleLabel.text = ModelConfig.mArticle[indexPath.row].title
                cell.mRecommendCellSourceButton.setTitle(ModelConfig.mArticle[indexPath.row].datasource_name, for: .normal)
                cell.mRecommendViewButton.setTitle(String(ModelConfig.mArticle[indexPath.row].pageview), for: .normal)
                return cell

            }else if indexPath.item % 5 == 4{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleAdsTVC", for: indexPath) as! GoogleAdsTVC
                cell.mGoogleAdsView.rootViewController = self
                return cell
          
                
            }else{
                
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
                
                if (Time <= 0) {
                    cell.mRecommendCellTime.setTitle("剛剛", for: .normal)
                } else {
                    cell.mRecommendCellTime.setTitle(String(lroundf(Float(Time)))+"小時前",for: .normal)
                }
                
                if (Time >= 24) {
                    
                    let timehr = Time/24
                    cell.mRecommendCellTime.setTitle(String(lroundf(Float(timehr)))+"天前",for: .normal)
                }
                cell.mRecommendCellImageView.sd_setImage(with: URL(string: ModelConfig.mArticle[indexPath.row].media?.small ?? ""), placeholderImage: UIImage(named: "image_null_tw"))
                cell.mRecommendCellTitle.text = ModelConfig.mArticle[indexPath.row].title
                cell.mRecommendCellSource.setTitle(ModelConfig.mArticle[indexPath.row].datasource_name, for: .normal)
                cell.mRecommendCellPageView.setTitle(String(ModelConfig.mArticle[indexPath.row].pageview), for: .normal)
                return cell
                
        }


    }
    
    
    
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: "SingleNews", bundle: nil)
    let initialViewController = storyboard.instantiateViewController(withIdentifier: "SingleNews") as! SingleNewsVC
    initialViewController.mNewsId = ModelConfig.mArticle[indexPath.row].id
    present(initialViewController, animated: true, completion: nil)
    }
    
}

extension RecommendTableViewVC:IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripViewController:PagerTabStripViewController) ->IndicatorInfo{
        
        return IndicatorInfo(title: ModelConfig.mCategory[0].name)
        
    }
    
}



