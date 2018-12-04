//
//  VideoTableViewCell.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/4.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift

class VideoTableViewCell: UITableViewCell {
    


    @IBOutlet weak var mYoutubePlayer: YouTubePlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        var playerParams : [String:AnyObject] = [:]
        playerParams["playsinline"] = 1 as AnyObject
        playerParams["autoplay"] = 1 as AnyObject
        playerParams["modestbranding"] = 0 as AnyObject
        playerParams["disablekb"] = 1 as AnyObject
        playerParams["iv_load_policy"] = 3 as AnyObject
        
        mYoutubePlayer.playerVars = playerParams
        
        // Initialization code
    }



    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
