//
//  SIngNewsHotTVC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/14.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class SIngNewsHotTVC: UITableViewCell,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var mTableView: UITableView!
    

    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        mTableView.dataSource = self
        mTableView.delegate = self

        mTableView.register(UINib(nibName: "HotTVC", bundle: nil), forCellReuseIdentifier: "HotTVC")
        
        
        mTableView.tableFooterView = UIView()
        mTableView.separatorColor = UIColor.clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HotTVC", for: indexPath) as! HotTVC
        
        
        return cell
        
    }
    
}
