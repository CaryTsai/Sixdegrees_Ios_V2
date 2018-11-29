//
//  LoginEvent.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/21.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import Foundation

class LoginEvent: NSObject {
    var mIsload: String;
    var mIsType:Bool
    
    init(isload: String,isType:Bool) {
        self.mIsload = isload
        self.mIsType = isType
    }

}
