//
//  LoadingVC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/21.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import SwiftEventBus
import MaterialComponents.MaterialSnackbar




class LoadingVC:BaseUiViewController{
    
    var mToken = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftEventBus.onMainThread(self, name: "LoadingEvent") { result in
            let loadevent : LoginEvent = result?.object as! LoginEvent
            
    
            
            if (loadevent.mIsType){
                
                if(loadevent.mIsload == LocalData.NO_USER_LOGIN){
                    
                    self.mToken = ApiService.bearer + getString(key: LocalData.CLIENT_TOKEN)
                    print("未登入")

                    
                }else{
                    
                    self.mToken = ApiService.bearer + getString(key: LocalData.ACCESS_TOKEN)
                    print("以登入")


                }
                
                self.getCategoryList()
                
            }else{
                
                self.dismiss(animated: true, completion: nil)
                
            }
        }
    }
    
    
    
    func getCategoryList(){
        
        
        Callback.mSharedInstance.fetchDefaultCategoryList(accesstoken: mToken) { (Category,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
                self.dismiss(animated: true, completion: nil)
//                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            
            switch code {
            case 200,201:
                guard let getCategory = Category else { return }
                ModelConfig.mCategory = getCategory
                print(ModelConfig.mCategory)
                self.getRecommendArticleList()
                print("喔喔喔喔喔")

            default:
                print("與伺服器連線中斷")
                self.dismiss(animated: true, completion: nil)
//                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
            
            
        }
        
        
    }
    
    
    func getRecommendArticleList(){
        
        
        Callback.mSharedInstance.fetchRecommendArticleList(accesstoken: mToken,page:1,limit:100) { (Article,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
                self.dismiss(animated: true, completion: nil)
//                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            
            switch code {
            case 200,201:
                guard let getArticle = Article else { return }
                ModelConfig.mArticle = getArticle
                print(ModelConfig.mArticle)
                self.getPopularArticleList()
            default:
                print("與伺服器連線中斷")
                self.dismiss(animated: true, completion: nil)
//                self.setSnackbar(mseeage: "與伺服器連線中斷")

            }
            
            
        }
        
        
    }
    
    
    func getPopularArticleList(){
        
        let timeType:String = "24h"

        
        Callback.mSharedInstance.fetchPopularArticleList(accesstoken: mToken,page:1,limit:20,timetype:timeType) { (Article,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
                self.dismiss(animated: true, completion: nil)
//                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            switch code {
            case 200,201:

                if(Article != nil){
                    
                    guard let getArticle = Article else { return }
                    ModelConfig.mPopularArticle = getArticle
                    print(ModelConfig.mPopularArticle)

                    
                }
           
                self.StoryBoardInstantiate(withIdentifier: "testVC")
            default:
                print("與伺服器連線中斷")
                self.dismiss(animated: true, completion: nil)
//                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
            
            
        }
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SwiftEventBus.unregister(self)
    }
    
    
    func setSnackbarLoading(mseeage:String,actiontitle:String){
        let message = MDCSnackbarMessage()
        message.text = mseeage
        let action = MDCSnackbarMessageAction()
        let actionHandler = {() in
            
          self.getCategoryList()
            
        }
        action.handler = actionHandler
        action.title = actiontitle
        message.action = action
        MDCSnackbarManager.show(message)
        
    }
    
    
    
}
