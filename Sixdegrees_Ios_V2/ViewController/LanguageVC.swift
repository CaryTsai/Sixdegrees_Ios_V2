//
//  ViewController.swift
//  Sixdegrees_Ios_V2
//
//  Created by Tsai Cary on 2018/11/9.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class LanguageVC: BaseUiViewController {

    @IBOutlet weak var LanguagEnImage: UIImageView!
    @IBOutlet weak var LanguagCnImage: UIImageView!
    @IBOutlet weak var LanguagTwImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LanguagEnImage.isHidden = true
        LanguagCnImage.isHidden = true
        LanguagTwImage.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }
 
    
    
    @IBAction func LanguageEnButton(_ sender: UIButton) {
        
        setButton(UIImageViewOne: LanguagEnImage,UIImageViewTwo: LanguagCnImage,UIImageViewThree: LanguagTwImage)
        saveString(key: LocalData.LANGUAGE_TYPE, value: LocalData.LANGUAGE_EN)
        
        
    }
    @IBAction func LanguagCnButton(_ sender: UIButton) {
        
        setButton(UIImageViewOne: LanguagCnImage,UIImageViewTwo: LanguagEnImage,UIImageViewThree: LanguagTwImage)
        saveString(key: LocalData.LANGUAGE_TYPE, value: LocalData.LANGUAGE_CN)

    }
    @IBAction func LanguagTwButton(_ sender: UIButton) {
        
        setButton(UIImageViewOne: LanguagTwImage,UIImageViewTwo: LanguagEnImage,UIImageViewThree: LanguagCnImage)
        saveString(key: LocalData.LANGUAGE_TYPE, value: LocalData.LANGUAGE_TW)

    }
    
    
    func setButton(UIImageViewOne:UIImageView,UIImageViewTwo:UIImageView,UIImageViewThree:UIImageView){
        
        UIImageViewOne.isHidden = false
        UIImageViewTwo.isHidden = true
        UIImageViewThree.isHidden = true
        StoryBoardInstantiate(withIdentifier:LocalData.LOGIN_VC)
        
    }
    
}
