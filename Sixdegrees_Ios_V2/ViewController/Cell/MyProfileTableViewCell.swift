//
//  MyProfileTableViewCell.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/12.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class MyProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var mTitleLb: UILabel!
    @IBOutlet weak var mMessageLb: UILabel!
    @IBOutlet weak var mContentView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
