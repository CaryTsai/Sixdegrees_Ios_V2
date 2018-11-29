//
//  RecommendCell.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/28.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class RecommendCell: UITableViewCell {
    @IBOutlet weak var mRecommendCellTitle: UILabel!
    @IBOutlet weak var mRecommendCellSource: UIButton!
    @IBOutlet weak var mRecommendCellTime: UIButton!
    @IBOutlet weak var mRecommendCellPageView: UIButton!
    @IBOutlet weak var mRecommendCellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
