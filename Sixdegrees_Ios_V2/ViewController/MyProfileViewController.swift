//
//  MyProfileViewController.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/12.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit

class MyProfileViewController: BaseUiViewController,UITableViewDataSource,UITableViewDelegate {
    

    @IBOutlet weak var mMyPohtoIv: UIImageView!
    @IBOutlet weak var mMyDataVc: UIView!
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mNameLb: UILabel!
    @IBOutlet weak var mUserLoginBt: UIButton!
    @IBOutlet weak var mBriefLb: UILabel!
    @IBOutlet weak var mUserLoginLb: UILabel!
    @IBOutlet weak var mCoinTitle: UILabel!
    @IBOutlet weak var mCoin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
 
    }
    
    @IBAction func mUserLoginAction(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "LocalLoginVC")
        present(initialViewController, animated: true, completion: nil)
        
    }
    
    func initView(){
        
        let userId = getInt(key: LocalData.USER_ID)
        
        
        if userId == 0{
            
            mMyPohtoIv.isHidden = true
            mCoin.isHidden = true
            mNameLb.isHidden = true
            mBriefLb.isHidden = true
            mUserLoginBt.isHidden = false
            mUserLoginLb.isHidden = false
            mCoinTitle.text = "我的六度幣"

        }else{
            
            let myData = ModelConfig.mUserInfo[0]
            mMyPohtoIv.isHidden = false
            mCoin.isHidden = false
            mBriefLb.isHidden = false
            mNameLb.isHidden = false
            mUserLoginBt.isHidden = true
            mUserLoginLb.isHidden = true
            mCoinTitle.text = "目前您的六度幣為"
            mCoin.text = String(myData.point ?? 0)
            mNameLb.text = myData.name
            mBriefLb.text =  myData.birthday ?? "一句話簡介"
        }
        
        
        mTableView.dataSource = self
        mTableView.delegate = self
        self.mTableView.isScrollEnabled = false
        
        let nibHeader = UINib(nibName: "MyProfileTableViewCell", bundle: nil)
        mTableView.register(nibHeader, forCellReuseIdentifier: "MyProfileTableViewCell")
        mTableView.tableFooterView = UIView()
        mTableView.separatorColor = UIColor.clear
        
        mMyPohtoIv.layer.cornerRadius = 15
        mMyDataVc.backgroundColor = .white
        mMyDataVc.layer.shadowOpacity = 0.2
        mMyDataVc.layer.shadowOffset = CGSize.init(width: 0, height: 5)
        
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyProfileTableViewCell", for: indexPath) as! MyProfileTableViewCell
        
        switch indexPath.item {
        case 0:
            cell.mTitleLb.text = "消息通知"
            cell.mMessageLb.isHidden = true
        case 1:
            cell.mTitleLb.text = "我的收藏"
            cell.mMessageLb.isHidden = true
        case 2:
            cell.mTitleLb.text = "我的評論"
            cell.mMessageLb.isHidden = true
        case 3:
            cell.mTitleLb.text = "我的點讚"
            cell.mMessageLb.isHidden = true
        case 4:
            cell.mTitleLb.text = "瀏覽歷史"
            cell.mMessageLb.isHidden = true
        default:
            cell.mTitleLb.text = "我的設置"
            cell.mMessageLb.isHidden = true
        }
        
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("dsdsds")
    }
    


}
