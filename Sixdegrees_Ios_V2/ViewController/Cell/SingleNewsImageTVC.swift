//
//  TableViewCell.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/14.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class SingleNewsImageTVC: UITableViewCell {
    @IBOutlet weak var mSingNewsBt: UIButton!
    @IBOutlet weak var mSingNewsTitleLb: UILabel!
    @IBOutlet weak var mSingNewsSourceBt: UIButton!
    @IBOutlet weak var mSingNewsTime: UIButton!
    @IBOutlet weak var mSingNewsPageViewBt: UIButton!
    @IBOutlet weak var mSingNewsIv: UIImageView!
    @IBOutlet weak var mSingNewsInnerLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mSingNewsBt.layer.cornerRadius = 10

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
