//
//  GoogleAdsTViC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/14.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GoogleAdsTVC: UITableViewCell {
    @IBOutlet weak var mGoogleAdsView: GADBannerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mGoogleAdsView.adUnitID = "ca-app-pub-6428195540030903/5353930239"
        mGoogleAdsView.load(GADRequest())
      
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
