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


class RecommendTableView: UITableViewController {

    
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
        return ModelConfig.mArticle.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Time = (getNowTimestamp() - ModelConfig.mArticle[indexPath.row].report_time) / 60 / 60
        print(Time)

            if(indexPath.item % 4 == 0){
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendHeaderCell", for: indexPath) as! RecommendHeaderCell
                
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

            }else{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendCell", for: indexPath) as! RecommendCell
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
    
    func getNowTimestamp() -> Double{
        return Double(Date().timeIntervalSince1970)
    }
    
}

extension RecommendTableView:IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripViewController:PagerTabStripViewController) ->IndicatorInfo{
        
        return IndicatorInfo(title: "推薦")
        
    }
    
}



