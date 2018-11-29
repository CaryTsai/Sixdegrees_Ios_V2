//
//  TableViewControllerOne.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/26.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import XLPagerTabStrip

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
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CallOne", for: indexPath) as! TableViewCellOne

        return cell
    }
    
}

extension TableViewControllerOne:IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripViewController:PagerTabStripViewController) ->IndicatorInfo{
        
        return IndicatorInfo(title: "Item one")
        
    }
    
}



