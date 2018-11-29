//
//  LoginVC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/9.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import SwiftEventBus



class LoginVC:BaseUiViewController{
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var JoinLaterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonStyle(Button: LoginButton)
        setButtonStyle(Button: RegisterButton)
        setButtonStyle(Button: JoinLaterButton)
        
    }
    
    @IBAction func LoginButton(_ sender: UIButton) {
        

        StoryBoardInstantiate(withIdentifier:LocalData.LOCAL_LOGIN_VC)

        
    }
    
    @IBAction func RegisterButton(_ sender: UIButton) {
        
        
        StoryBoardInstantiate(withIdentifier:LocalData.REGISTER_VC)
    }
    
    @IBAction func JoinLaterButton(_ sender: Any) {
        
        
//        StoryBoardInstantiate(withIdentifier:LocalData.LOADING_VC)

        if let controller = storyboard?.instantiateViewController(withIdentifier: LocalData.LOADING_VC) {
            present(controller, animated: true, completion: nil)
            SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.NO_USER_LOGIN, isType: true))
        }

        
        
    }

    
}
