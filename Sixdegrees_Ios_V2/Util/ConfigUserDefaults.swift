//
//  UserDefaultsConfig.swift
//  Sixdegrees_Ios_V2
//
//  Created by Tsai Cary on 2018/11/18.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import Foundation


func saveString(key:String,value:String){
    UserDefaults.standard.set(value, forKey: key)
}

func getString(key:String) -> String {
    return UserDefaults.standard.string(forKey: key) ?? ""
}
func saveInt(key:String,value:Int){
    UserDefaults.standard.set(value, forKey: key)
}

func getInt(key:String) -> Int {
    return UserDefaults.standard.integer(forKey: key)
}

func saveDouble(key:String,value:Double){
    UserDefaults.standard.set(value, forKey: key)
}

func getDouble(key:String) -> Double {
    return UserDefaults.standard.double(forKey: key)
}

func saveBool(key:String,value:Bool){
    UserDefaults.standard.set(value, forKey: key)
}

func getBool(key:String) -> Bool {
    return UserDefaults.standard.bool(forKey: key)
}

func clearUserDefaults(){
    if let bundle = Bundle.main.bundleIdentifier {
        UserDefaults.standard.removePersistentDomain(forName: bundle)
    }
}
