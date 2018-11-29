//
//  FrogetPassword.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/11/13.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit


class ForgetPasswordVC:BaseUiViewController {
    @IBOutlet weak var SendButton: UIButton!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var IndicatorView: UIActivityIndicatorView!
    
    var mEmail:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        EmailTextField.addTarget(self, action: #selector(EmailTarget(_:)), for: .editingChanged)
        setIndiicatorStyle(ishidden: true)

        
    }
   
    func initView(){
        
        setButtonStyle(Button: SendButton)

    }
    
    @IBAction func SendAction(_ sender: UIButton) {
        
        if(mEmail != ""){
            
            getForgotPassword()

            
        }else{
            
            print("請輸入E-mail")
            self.setSnackbar(mseeage: "請輸入E-mail")
            
        }

        
    }
    
    @objc func EmailTarget(_ UITextField:UITextField){
        
        mEmail = EmailTextField.text!

    }
    
    @IBAction func BackAction(_ sender: UIButton) {
        
        dismiss(animated: true, completion: nil)

    }
    
    
    
    
    func getForgotPassword(){
        
        setIndiicatorStyle(ishidden: false)
        Callback.mSharedInstance.fetchForgotPassword(email: mEmail)  { (GetStatus,code,error) in
            
            if let error = error{
                print("網路連線不良",error)
                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            
            switch code {
            case 200,201:
                guard let getServerResponse = GetStatus else { return }
                self.setIndiicatorStyle(ishidden: true)
                print(getServerResponse)
            case 409:
                print("此E-mail不存在")
                self.setIndiicatorStyle(ishidden: true)
                self.setSnackbar(mseeage: "此E-mail不存在")
            default:
                print("與伺服器連線中斷")
                self.setIndiicatorStyle(ishidden: true)
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
