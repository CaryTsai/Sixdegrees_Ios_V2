//
//  NewListEvent.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/3.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import Foundation

class NewListEvent: NSObject {
    var mTabName:String
//    var mTabId:Int
    
    init(tabname: String) {
        self.mTabName = tabname
//        self.mTabId = tabid
    }
    
}
