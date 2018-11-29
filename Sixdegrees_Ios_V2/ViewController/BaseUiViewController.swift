//
//  UiColorData.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/9.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import SwiftEventBus
import MaterialComponents.MaterialSnackbar


class BaseUiViewController:UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getClientToken()
    }
    
    
    func setButtonStyle(Button:UIButton){
        
        Button.layer.cornerRadius = 10.0
        Button.layer.borderWidth = 1.0
        Button.layer.borderColor = UIColor.ColorBlue().cgColor
        Button.backgroundColor = UIColor.ColorBlue()
        Button.setTitleColor(UIColor.white,for:.normal)
    }
    
    
    func StoryBoardInstantiate(withIdentifier:String){
    
        if let controller = storyboard?.instantiateViewController(withIdentifier: withIdentifier) {
            present(controller, animated: true, completion: nil)
        }
        
    }
    
    
    func getClientToken(){
        let systemTime = getNowTimestamp()
        let clientTime = getDouble(key: LocalData.CLIENT_EXPIRES)

        if(clientTime <= systemTime){
        
            Callback.mSharedInstance.fetchClientToken { (token, error) in
                if let error = error{
                    print("Failed to fetch client token:",error)
                    return
                }
                
                guard let getToken = token else { return }
                let clientTokenTime =  self.getNowTimestamp() + getToken.expires_in - 86400
                saveString(key: LocalData.CLIENT_TOKEN, value:getToken.access_token)
                saveDouble(key: LocalData.CLIENT_EXPIRES, value: clientTokenTime)
                print("fetch client token successfully."+getToken.access_token)
            }
            
        }
    
    }
    
    func setSnackbar(mseeage:String){
        let message = MDCSnackbarMessage()
        message.text = mseeage
        MDCSnackbarManager.show(message)

    }
    
    
    func getNowTimestamp() -> Double{
        return Double(Date().timeIntervalSince1970)
    }
    
    
}




