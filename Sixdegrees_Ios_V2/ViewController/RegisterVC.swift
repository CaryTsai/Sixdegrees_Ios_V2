//
//  RegisterVC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/13.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import SwiftEventBus


class RegisterVC:BaseUiViewController{
    
    @IBOutlet weak var UserNameField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var AgainPasswordField: UITextField!
    @IBOutlet weak var RegisterButton: UIButton!
    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var UserCode: UITextField!
    @IBOutlet weak var IndicatorView: UIActivityIndicatorView!
    
    
    var mUserName = ""
    
    var mEmail = ""
    
    var mPasswrod = ""
    
    var mAgainPassword = ""
    
    var mCode = ""
    
    var mIsCheck = true
    
    var mCheckEnableImage = UIImage.init(named: LocalData.CHECK_BOX_ENABLE_IMAGE)
    
    var mCheckDisableImage = UIImage.init(named: LocalData.CHECK_BOX_DISABLE_IMAGE)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        UserNameField.addTarget(self, action: #selector(UserNameTaget(_:)), for: .editingChanged)
        EmailField.addTarget(self, action: #selector(EmaiTaget(_:)), for: .editingChanged)
        PasswordField.addTarget(self, action: #selector(PasswordTaget(_:)), for: .editingChanged)
        UserCode.addTarget(self, action: #selector(CodeTaget(_:)), for: .editingChanged)
        AgainPasswordField.addTarget(self, action: #selector(AgainPasswordTaget(_:)), for: .editingChanged)
        setIndiicatorStyle(ishidden: true)



        
    }
    
    
    func initView(){
        
        setButtonStyle(Button: RegisterButton)
        PasswordField.isSecureTextEntry = true
        AgainPasswordField.isSecureTextEntry = true

    }
    
    @IBAction func BackAction(_ sender: UIButton) {
        
        dismiss(animated:true, completion: nil)
        
    }
    
    
    @IBAction func CheckAction(_ sender: UIButton) {
        
        if(mIsCheck){
            
            CheckButton.setBackgroundImage(mCheckDisableImage,for:.normal)
            RegisterButton.backgroundColor = UIColor.colorGray()
            RegisterButton.layer.borderColor = UIColor.colorGray().cgColor
            RegisterButton.isEnabled = false
            mIsCheck = false
            
            
        }else{
            
            CheckButton.setBackgroundImage(mCheckEnableImage,for:.normal)
            RegisterButton.backgroundColor = UIColor.ColorBlue()
            RegisterButton.layer.borderColor = UIColor.ColorBlue().cgColor
            RegisterButton.isEnabled = true
            mIsCheck = true            
            
            
        }
        
    }
    
    

    
    @IBAction func RegisterAction(_ sender: UIButton) {
        
        let UserString = ""
        
        switch UserString {
        case mUserName,mEmail,mPasswrod:
            print("請輸入帳號密碼")
            self.setSnackbar(mseeage: "請輸入帳號密碼")
        default:
            
            if(mPasswrod == mAgainPassword){
                
                if let controller = self.storyboard?.instantiateViewController(withIdentifier: LocalData.LOADING_VC) {
                    self.present(controller, animated: true, completion: nil)
                }
               self.getRegister()
                
                
            }
        }
    }
    
    
    @objc func UserNameTaget(_ sender:UITextField){
        
        mUserName = UserNameField.text!
        
    }
    
    @objc func EmaiTaget(_ sender:UITextField){
        
        mEmail = EmailField.text!
        
    }
    
    @objc func PasswordTaget(_ sender:UITextField){
        
        mPasswrod = PasswordField.text!
        
    }
    
    @objc func AgainPasswordTaget(_ sender:UITextField){
        
        mAgainPassword = AgainPasswordField.text!

    }
    
    @objc func CodeTaget(_ sender:UITextField){
        
        mCode = UserCode.text!
        
    }
    
    

    
    
    func getRegister(){
        
        self.setIndiicatorStyle(ishidden: false)
        Callback.mSharedInstance.fetchMemberRegister(email: mEmail, password: mPasswrod, name: mUserName,code:mCode)  { (Token,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
               self.setIndiicatorStyle(ishidden: true)
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            
            switch code {
            case 200,201:
                self.setIndiicatorStyle(ishidden: true)
                guard let getToken = Token else { return }
                self.StoryBoardInstantiate(withIdentifier: LocalData.LOADING_VC)
                let clientTokenTime =  self.getNowTimestamp() + getToken.expires_in - 86400
                saveString(key: LocalData.ACCESS_TOKEN, value:getToken.access_token)
                saveString(key: LocalData.REFRESH_TOKEN, value:getToken.refresh_token ?? "")
                saveDouble(key: LocalData.CLIENT_EXPIRES, value: clientTokenTime)
                saveString(key: LocalData.USER_NAME, value: getToken.user?.name ?? "")
                saveString(key: LocalData.USER_EMAIL, value: getToken.user?.email ?? "")
                saveInt(key: LocalData.USER_ID, value: getToken.user?.id ?? 0)
                print(getToken)
                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: true))
            case 409:
                print("此Email已被註冊")
                self.setIndiicatorStyle(ishidden: true)
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                self.setSnackbar(mseeage: "此Email已被註冊")
            default:
                print("與伺服器連線中斷")
                self.setIndiicatorStyle(ishidden: true)
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
        }
    }
    
    func setIndiicatorStyle(ishidden:Bool){
        
        IndicatorView.isHidden = ishidden
        IndicatorView.color = UIColor.ColorBlue()
        IndicatorView.startAnimating()
        self.IndicatorView.transform = CGAffineTransform(scaleX: 2, y: 2)
        
    }
    
    
}
