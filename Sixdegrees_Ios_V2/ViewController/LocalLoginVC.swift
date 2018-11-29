//
//  LocalLoginVC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/9.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import SwiftEventBus
import FacebookLogin
import FacebookCore
import GoogleSignIn
import TwitterKit








class LocalLoginVC:BaseUiViewController,GIDSignInUIDelegate{
    
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var NumberTextField: UITextField!
    @IBOutlet weak var DetermineButton: UIButton!
    @IBOutlet weak var NumberLineView: UIView!
    @IBOutlet weak var PasswordLineView: UIView!
    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var FacebookButton: UIButton!
    @IBOutlet weak var TwitterButton: UIButton!
    @IBOutlet weak var IndiicatorView: UIActivityIndicatorView!
    
    
    var mNumberText = ""
    var mPassworTexr = ""
    var mCheckEnableImage = UIImage.init(named: LocalData.CHECK_BOX_ENABLE_IMAGE)
    var mCheckDisableImage = UIImage.init(named: LocalData.CHECK_BOX_DISABLE_IMAGE)
    var mCheckBoolean = true
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        setButtonStyle(Button: DetermineButton)
        setIndiicatorStyle(ishidden: true)
        PasswordTextField.isSecureTextEntry = true
        PasswordTextField.addTarget(self, action: #selector(PasswordTextField(_:)), for: .editingChanged)
        NumberTextField.addTarget(self, action: #selector(NumberTextField(_:)), for: .editingChanged)

    }
    
    @IBAction func BackAction(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func setIndiicatorStyle(ishidden:Bool){
        
        IndiicatorView.isHidden = ishidden
        IndiicatorView.color = UIColor.ColorBlue()
        IndiicatorView.startAnimating()
        self.IndiicatorView.transform = CGAffineTransform(scaleX: 2, y: 2)
        
    }
    
    @IBAction func DetermineAction(_ sender: UIButton) {
        
        
        if (mNumberText != "" && mPassworTexr != "") {
            
            mPasswordToken()


        }else{
            
            setSnackbar(mseeage: "請輸入帳號密碼")
            

        }
        
        
    }
    
    @objc fileprivate func handleGoogleLogin(){
        GIDSignIn.sharedInstance().signIn()
    }
    
   
    

    //Facebook Login
    @IBAction func FacebookAction(_ sender: UIButton) {
        
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) { (loginResult) in
            switch loginResult{
            case .failed(let error):
                print(error)
            //失敗的時候回傳
            case .cancelled:
                print("the user cancels login")
            //取消時回傳內容
            case .success(grantedPermissions: _, declinedPermissions: _, token: _):
                let param = ["fields":"name, email , gender,age_range"]
                let graphRequest = GraphRequest(graphPath: "me",parameters: param)
                graphRequest.start { (urlResponse, requestResult) in
                    switch requestResult{
                    case .failed(let error):
                        print(error)
                    case .success(response: let graphResponse):
                        if let responseDictionary = graphResponse.dictionaryValue{
                            guard let username = responseDictionary["name"] as? String else { return }
                            guard let facebookId = responseDictionary["id"] as? String else { return }
                            guard let useremail = responseDictionary["email"] as? String else {return }
                            print(username)
                            print(facebookId)
                            print(useremail)
                           self.getFacebookLogin(fbemali: useremail, fbId: facebookId, fbname: username)
                        }
                    }
                }
            }
        }
        
    }
    
    @objc fileprivate func handleTwitterLogin(){
        TWTRTwitter.sharedInstance().logIn(completion: { (session,error) in
            if let error = error{
                print("error:",error)
//                self.view.makeToast(CustomLanguage.share.showText(key: "pleaseInstallTiwtterApp"),position: .center)
                return
            }
            guard let twitterId = session?.userID else { return }
            guard let userName = session?.userName else { return }
            print("userName:",userName)
            
            let client = TWTRAPIClient.withCurrentUser()
            
            client.requestEmail { email, error in
                if let error = error{
                    print("error:",error)
                    return
                }
                guard let userEmail = email else { return }
                print("signed in as \(userEmail)")
                self.getTwitterLogin(twemali: userEmail, twId: twitterId, twname: userName)
//                self.fetchTwitterLogin(username: userName, useremail: userEmail, twitterId: twitterId)
            }
            
        })
    }
    
    
    @IBAction func GoogleAction(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()

    }
    
    @IBAction func Twitter(_ sender: UIButton) {
        
        guard let twiiterUrl = URL(string: "twitter://timeline") else { return }
        if UIApplication.shared.canOpenURL(twiiterUrl) {
            
            handleTwitterLogin()

        }else{
            
            setSnackbar(mseeage: "請安裝twitter App")

            
        }
    }
    
    @IBAction func ForgetAction(_ sender: UIButton) {

        StoryBoardInstantiate(withIdentifier: LocalData.FORGET_PASSWORD_VC)
        
    }
    
    
    

    @IBAction func RegisterAction(_ sender: UIButton) {
        

        
    }
    
    
    @objc func PasswordTextField(_ textField:UITextField) {
        mPassworTexr = PasswordTextField.text!
        print(mPassworTexr)
    }
    
    @objc func NumberTextField(_ textField:UITextField) {
        mNumberText = NumberTextField.text!
        print(mNumberText)

    }

    @IBAction func CheckAction(_ sender: UIButton) {
    
 

        if(mCheckBoolean){

            CheckButton.setBackgroundImage(mCheckDisableImage,for:.normal)
            DetermineButton.backgroundColor = UIColor.colorGray()
            DetermineButton.layer.borderColor = UIColor.colorGray().cgColor
            DetermineButton.isEnabled = false
            mCheckBoolean = false


        }else{

            CheckButton.setBackgroundImage(mCheckEnableImage,for:.normal)
            DetermineButton.backgroundColor = UIColor.ColorBlue()
            DetermineButton.layer.borderColor = UIColor.ColorBlue().cgColor
            DetermineButton.isEnabled = true
            mCheckBoolean = true
        }

        
    }
    
    
    func mPasswordToken(){
        self.setIndiicatorStyle(ishidden: false)
        Callback.mSharedInstance.fetchMemberToken(useremail:mNumberText,password:mPassworTexr){ (token, code,error) in
  
            if let error = error{
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                print("網路連線不良",error)
                self.setSnackbar(mseeage: "網路連線不良")

                return
            }
            
            switch code {
            case 200,201:
                self.StoryBoardInstantiate(withIdentifier: LocalData.LOADING_VC)
                guard let getToken = token else { return }
                print("fetch client token successfully."+getToken.access_token)
                let clientTokenTime =  self.getNowTimestamp() + getToken.expires_in - 86400
                saveString(key: LocalData.ACCESS_TOKEN, value:getToken.access_token)
                saveString(key: LocalData.REFRESH_TOKEN, value:getToken.refresh_token ?? "")
                saveDouble(key: LocalData.CLIENT_EXPIRES, value: clientTokenTime)
                saveString(key: LocalData.USER_NAME, value: getToken.user?.name ?? "")
                saveString(key: LocalData.USER_EMAIL, value: getToken.user?.email ?? "")
                saveInt(key: LocalData.USER_ID, value: getToken.user?.id ?? 0)
                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: true))
                self.setIndiicatorStyle(ishidden: true)
            case 400:
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                print("帳號密碼錯誤")
                self.setIndiicatorStyle(ishidden: true)
                self.setSnackbar(mseeage: "帳號密碼錯誤")

            default:
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                print("與伺服器連線中斷")
                self.setIndiicatorStyle(ishidden: true)
                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
            
        }
    }
    
    
    func getFacebookLogin(fbemali:String,fbId:String,fbname:String){
        
//        if let controller = self.storyboard?.instantiateViewController(withIdentifier: LocalData.LOADING_VC) {
//            self.present(controller, animated: true, completion: nil)
//        }
        self.setIndiicatorStyle(ishidden: false)
        Callback.mSharedInstance.fetchFacebook(email:fbemali, facebookId: fbId, name: fbname)  { (Token,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                self.setSnackbar(mseeage: "網路連線不良")
                self.setIndiicatorStyle(ishidden: true)
                return
            }
            
            switch code {
            case 200,201:
                self.StoryBoardInstantiate(withIdentifier: LocalData.LOADING_VC)
                guard let getToken = Token else { return }
                let clientTokenTime =  self.getNowTimestamp() + getToken.expires_in - 86400
                saveString(key: LocalData.ACCESS_TOKEN, value:getToken.access_token)
                saveString(key: LocalData.REFRESH_TOKEN, value:getToken.refresh_token ?? "")
                saveDouble(key: LocalData.CLIENT_EXPIRES, value: clientTokenTime)
                saveString(key: LocalData.USER_NAME, value: getToken.user?.name ?? "")
                saveString(key: LocalData.USER_EMAIL, value: getToken.user?.email ?? "")
                saveInt(key: LocalData.USER_ID, value: getToken.user?.id ?? 0)
                print(getToken)
                self.setIndiicatorStyle(ishidden: true)
                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: true))
            default:
                print("與伺服器連線中斷")
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                self.setIndiicatorStyle(ishidden: true)
                self.setSnackbar(mseeage: "與伺服器連線中斷")

            }
        }
    }
    
    func getTwitterLogin(twemali:String,twId:String,twname:String){
        

        
        Callback.mSharedInstance.fetchTwitter(email:twemali, twitterId: twId, name: twname)  { (Token,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                self.setIndiicatorStyle(ishidden: true)
                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            
            switch code {
            case 200,201:
                self.StoryBoardInstantiate(withIdentifier: LocalData.LOADING_VC)
                guard let getToken = Token else { return }
                let clientTokenTime =  self.getNowTimestamp() + getToken.expires_in - 86400
                saveString(key: LocalData.ACCESS_TOKEN, value:getToken.access_token)
                saveString(key: LocalData.REFRESH_TOKEN, value:getToken.refresh_token ?? "")
                saveDouble(key: LocalData.CLIENT_EXPIRES, value: clientTokenTime)
                saveString(key: LocalData.USER_NAME, value: getToken.user?.name ?? "")
                saveString(key: LocalData.USER_EMAIL, value: getToken.user?.email ?? "")
                saveInt(key: LocalData.USER_ID, value: getToken.user?.id ?? 0)
                print(getToken)
                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: true))
            default:
                print("與伺服器連線中斷")
//                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                self.setIndiicatorStyle(ishidden: true)
                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
        }
    }
}
