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


class PopularTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ModelConfig.mPopularArticle.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Time = (getNowTimestamp() - ModelConfig.mPopularArticle[indexPath.row].report_time) / 60 / 60
        print(Time)
        
        let cellIdentifier = "RecommendCell"
//            let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendCell", for: indexPath) as! RecommendCell
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RecommendCell
        
        
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
    
    func getNowTimestamp() -> Double{
        return Double(Date().timeIntervalSince1970)
    }
    
    
}

extension PopularTableViewController:IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripViewController:PagerTabStripViewController) ->IndicatorInfo{
        
        return IndicatorInfo(title: "推薦")
        
    }
    
}
