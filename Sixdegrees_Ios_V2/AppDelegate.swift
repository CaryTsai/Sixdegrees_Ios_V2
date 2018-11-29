//
//  AppDelegate.swift
//  Sixdegrees_Ios_V2
//
//  Created by Tsai Cary on 2018/11/9.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import SwiftEventBus
import FacebookCore
import GoogleSignIn
import Firebase
import TwitterKit
import MaterialComponents.MaterialSnackbar




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {

    var window: UIWindow?
    
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let passwordToken = getString(key: LocalData.ACCESS_TOKEN)
        let clientToken = getString(key: LocalData.CLIENT_TOKEN)
//        GADMobileAds.configure(withApplicationID: "ca-app-pub-6428195540030903~6093077083")
        TWTRTwitter.sharedInstance().start(withConsumerKey: "uTEJ9lXiry4S8lRkEtb2CzMXL", consumerSecret: "YC6Fov97BZS1N306pn4bp2GJwat7xP9QLcAq24xc4CzC37s1kb")
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        Thread.sleep(forTimeInterval: 1.0)


        
        if(passwordToken == ""){
            
            if(clientToken == ""){
                
                getClientToken()
                
                
            }else{
            
                getLanguage()
                
            }
            
            
        }else{
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: LocalData.LOADING_VC)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: true))

            
            
            
        }
  

 
        
        
        return true
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print(error)
            return
        }
        guard let authentication = user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error)
                return
            }

            guard let username = user?.displayName else { return }
            guard let googleId = user?.uid else { return }
            guard let useremail = user?.email else { return }
            
//            saveString(key:LocalData.GOOGLE_NAME,value: username)
//            saveString(key:LocalData.GOOGLE_ID,value: googleId)
//            saveString(key:LocalData.GOOGLE_EMAIL,value: useremail)
            self.getGoogleLogin(googleemali: useremail, googleId: googleId, googlename: username)
            print(username,googleId,useremail)

        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled = false
        if url.absoluteString.contains("fb"){
            handled = SDKApplicationDelegate.shared.application(app, open: url, options: options)
        }else if url.absoluteString.contains("twitterkit"){
            
            handled = TWTRTwitter.sharedInstance().application(app, open: url, options: options)
            
        }else{
            handled = GIDSignIn.sharedInstance().handle(url as URL?,
                                                        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        }
//        Branch.getInstance().application(app, open: url, options: options)
        return handled
        }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func getClientToken(){
        
        
        
        Callback.mSharedInstance.fetchClientToken { (token, error) in
            if let error = error{
                print("Failed to fetch client token:",error)
                self.setSnackbar(mseeage: "網路連線不良",actiontitle: "重試")
                return
            }
            
            guard let getToken = token else { return }
            let clientTokenTime =  self.getNowTimestamp() + getToken.expires_in - 86400
            saveString(key: LocalData.CLIENT_TOKEN, value:getToken.access_token)
            saveDouble(key: LocalData.CLIENT_EXPIRES, value: clientTokenTime)
            print("fetch client token successfully."+getToken.access_token)
        }
        
        
    }
    
    func getLanguage(){
        
        let languagType = getString(key: LocalData.LANGUAGE_TYPE)
        
        
        if(languagType == ""){
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: LocalData.LANGUAGE_VC)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
            
        }else{
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: LocalData.LOGIN_VC)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
            
            
        }
        

        
        
        
        
    }
    
    func getNowTimestamp() -> Double{
        return Double(Date().timeIntervalSince1970)
    }
    
    
    
    func getGoogleLogin(googleemali:String,googleId:String,googlename:String){
        let message = MDCSnackbarMessage()
        Callback.mSharedInstance.fetchGoogle(email:googleemali, googleId: googleId, name: googlename)  { (Token,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
                message.text = "網路連線不良"
                MDCSnackbarManager.show(message)
                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
                return
            }
            
            switch code {
            case 200,201:
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: LocalData.LOADING_VC)
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
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
                message.text = "與伺服器連線中斷"
                MDCSnackbarManager.show(message)
                SwiftEventBus.post("LoadingEvent",sender: LoginEvent(isload: LocalData.LOCAL_LOGIN_VC, isType: false))
            }
        }
    }
    
    
    func setSnackbar(mseeage:String,actiontitle:String){
        let message = MDCSnackbarMessage()
        message.text = mseeage
        let action = MDCSnackbarMessageAction()
        let actionHandler = {() in
            
           self.getClientToken()
      
        }
        action.handler = actionHandler
        action.title = actiontitle
        message.action = action
        MDCSnackbarManager.show(message)
        
    }
    
}

