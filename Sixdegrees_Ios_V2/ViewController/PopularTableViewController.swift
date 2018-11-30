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


class PopularTableViewController: BaseUiViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mButtonBar: UIView!
    
    @IBOutlet weak var m24hButton: UIButton!
    @IBOutlet weak var m3dayButton: UIButton!
    @IBOutlet weak var m7dayButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setButtonStyle()

    }
    
    
    func initView(){
        
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        mTableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        mTableView.tableFooterView = UIView()
        mTableView.dataSource = self
        mTableView.delegate = self
        mTableView.separatorColor = UIColor.clear
        mButtonBar.clipsToBounds = true
        mButtonBar.layer.cornerRadius = 5
        
    }
    
    func setButtonStyle(){
        
        m24hButton.backgroundColor = UIColor.ColorBlue()
        m24hButton.setTitleColor(UIColor.white,for:.normal)
        m24hButton.layer.cornerRadius = 5
        m24hButton.setImage(UIImage(named: "popular_24hours.png"), for: .normal)
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

extension PopularTableViewController:IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripViewController:PagerTabStripViewController) ->IndicatorInfo{
        
        return IndicatorInfo(title: "推薦")
        
    }
    
}
