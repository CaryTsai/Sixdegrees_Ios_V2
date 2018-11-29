//
//  TableViewCellOne.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/26.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class RecommendHeaderCell: UITableViewCell {

    @IBOutlet weak var mRecommendCellImageView: UIImageView!
    @IBOutlet weak var mRecommendCellTitleLabel: UILabel!
    @IBOutlet weak var mRecommendCellSourceButton: UIButton!
    @IBOutlet weak var mRecommendCellTimeButton: UIButton!
    @IBOutlet weak var mRecommendViewButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        mRecommendCellTitleLabel.text = ModelConfig.mArticle[0].title
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
