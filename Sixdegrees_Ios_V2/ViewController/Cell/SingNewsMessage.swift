//
//  SingNewsMessage.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/17.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class SingNewsMessage: UITableViewCell {
    @IBOutlet weak var mMessagePhotoIV: UIImageView!
    @IBOutlet weak var mMessageNameLb: UILabel!
    @IBOutlet weak var mMessageLikeBt: UIButton!
    @IBOutlet weak var mMessageLb: UILabel!
    @IBOutlet weak var mMessageTime: UILabel!
    @IBOutlet weak var mMessageBt: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mMessagePhotoIV.clipsToBounds = true
        mMessagePhotoIV.layer.cornerRadius = 20

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
