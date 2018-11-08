//
//  ViewController.swift
//  Sixdegrees_Ios_V2
//
//  Created by Tsai Cary on 2018/11/9.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

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
        setLanguageType(languageType:"En")
        
    }
    @IBAction func LanguagCnButton(_ sender: UIButton) {
        
        setButton(UIImageViewOne: LanguagCnImage,UIImageViewTwo: LanguagEnImage,UIImageViewThree: LanguagTwImage)
        setLanguageType(languageType:"Cn")

    }
    @IBAction func LanguagTwButton(_ sender: UIButton) {
        
        setButton(UIImageViewOne: LanguagTwImage,UIImageViewTwo: LanguagEnImage,UIImageViewThree: LanguagCnImage)
        setLanguageType(languageType:"Tw")

    }
    
    
    func setButton(UIImageViewOne:UIImageView,UIImageViewTwo:UIImageView,UIImageViewThree:UIImageView){
        
        UIImageViewOne.isHidden = false
        UIImageViewTwo.isHidden = true
        UIImageViewThree.isHidden = true
        
    }
    
}
