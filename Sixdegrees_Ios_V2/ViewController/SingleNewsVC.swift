//
//  NewsVC.swift
//  Sixdegrees_Ios_V2
//
//  Created by 蔡纘書 on 2018/12/13.
//  Copyright © 2018 Tsai Cary. All rights reserved.
//

import UIKit
import GoogleMobileAds
import SDWebImage



class SingleNewsVC: BaseUiViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mCommentView: UIView!
    @IBOutlet weak var mCommentTf: UITextField!
    @IBOutlet weak var mCommentMessage: UIButton!
    @IBOutlet weak var mCommentKeep: UIButton!
    @IBOutlet weak var mCommentLink: UIButton!
    @IBOutlet weak var mCommentShare: UIButton!
    @IBOutlet weak var mCommentSend: UIButton!
    @IBOutlet weak var mCommentTotal: UILabel!
    
    
    @IBOutlet weak var commentTextviewWidthConstraint: NSLayoutConstraint!
    
    
    var mToken:String = ""
    var mNewsId=Int()
    var mNewsData = [ArticleDetail]()
    var mlatestCount = 0
    var mCommentCount = 0
    var mIsKeep = false
    var mIsLink = false
    var mIsCommentLink = "discard"
    var mUserId = 0
    var mLinkmessageLb = 0


    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mBackAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mSearchAction(_ sender: Any) {
        
    }
    
    @IBAction func mShareAction(_ sender: Any) {
        
        let activityViewController = UIActivityViewController(activityItems: [mNewsData[0].share_url], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    @IBAction func mSendAction(_ sender: Any) {
        
//        print("message",mCommentTf.text)
        
        if mUserId == 0 {
            
     
            
             print("請先登入會員")
            
            
        }else{
            
            
            if mCommentTf.text! != "" {
                
                
                getfetchComment(text: mCommentTf.text!)
                self.mCommentTf.text! = ""
                self.view.endEditing(false)
                
            }else{
                
                print("請填寫留言")

            }
            
      

            
            
        }
        
    }
    @IBAction func mMessageAction(_ sender: Any) {
        
    }
    @IBAction func mKeepAction(_ sender: Any) {
        
        
        if mUserId == 0{
            
          
            print("請先登入會員")
            
            
        }else{
            
            if mIsKeep {
                
                self.mCommentKeep.setImage(UIImage.init(named: LocalData.KEEP_IMAGE_UNSELECT), for: .normal)
                mIsKeep = false
                
                
            }else{
                
                self.mCommentKeep.setImage(UIImage.init(named: LocalData.KEEP_IMAGE_SELECT), for: .normal)
                mIsKeep = true
            }
            
            getKeepArticle()

        }


    }
    @IBAction func mLinkAction(_ sender: Any) {
        
        if mUserId == 0{
            
            print("請先登入會員")

            
        }else{
            
            if mIsLink {
                
                self.mCommentLink.setImage(UIImage.init(named: LocalData.LINK_IMAGE_UNSELECT), for: .normal)
                mIsLink = false
                
                
            }else{
                
                self.mCommentLink.setImage(UIImage.init(named: LocalData.LINK_IMAGE_SELECT), for: .normal)
                mIsLink = true
            }
            
            
            
        }
        getLinkArticle()
        
        
    }
    @IBAction func mCommentShareAction(_ sender: Any) {
        
        let activityViewController = UIActivityViewController(activityItems: [mNewsData[0].share_url], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
        
  
    }
    
    

    func initView(){
        
        print("NewsId",mNewsId)
        mCommentSend.isHidden = true
        mCommentTotal.clipsToBounds = true
        mCommentTotal.layer.cornerRadius = 3
        mUserId = getInt(key: LocalData.USER_ID)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow(note:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

      
        if(mUserId == 0){
            
            mToken = ApiService.bearer+getString(key: LocalData.CLIENT_TOKEN)
           
        }else{
            
            mToken = ApiService.bearer+getString(key: LocalData.ACCESS_TOKEN)
            
        }
        
        getfetchArticle()

        self.mTableView.register(UINib(nibName: "SingleNewsImageTVC", bundle: nil), forCellReuseIdentifier: "SingleNewsImageTVC")
        self.mTableView.register(UINib(nibName: "SingNewsMessage", bundle: nil), forCellReuseIdentifier: "SingNewsMessage")
        self.mTableView.register(UINib(nibName: "GoogleAdsTVC", bundle: nil), forCellReuseIdentifier: "GoogleAdsTVC")
        self.mTableView.register(UINib(nibName: "SIngNewsHotTVC", bundle: nil), forCellReuseIdentifier: "SIngNewsHotTVC")
        self.mTableView.tableFooterView = UIView()
        self.mTableView.separatorColor = UIColor.clear
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @objc func keyboardShow(note: Notification)  {
        guard let userInfo = note.userInfo else {return}
        guard let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else{return}
        
        
        print(keyboardRect.origin.y)
        print(UIScreen.main.bounds.height)
        
        var moffsetY = CGFloat()
        let mainWindow = UIWindow()
        
        
        if mainWindow.safeAreaInsets.top > 24 {
            
            moffsetY = keyboardRect.origin.y - UIScreen.main.bounds.height+35
            
            
        }else{
            
            moffsetY = keyboardRect.origin.y - UIScreen.main.bounds.height
            
            
        }
        
        print(moffsetY)
        mCommentView.transform = CGAffineTransform(translationX: 0, y:moffsetY)
        commentTextviewWidthConstraint.constant = 325
        
        mCommentMessage.isHidden = true
        mCommentKeep.isHidden = true
        mCommentLink.isHidden = true
        mCommentShare.isHidden = true
        mCommentTotal.isHidden = true
        mCommentSend.isHidden = false
    }
    
    @objc func keyboardHidden(note: Notification){
        
        mCommentView.transform = CGAffineTransform(translationX: 0, y:0)
        commentTextviewWidthConstraint.constant = 140
        mCommentMessage.isHidden = false
        mCommentKeep.isHidden = false
        mCommentLink.isHidden = false
        mCommentShare.isHidden = false
        mCommentTotal.isHidden = false
        mCommentSend.isHidden = true
        
    }
    
    
    func getfetchArticle(){
        
        mTableView.isHidden = true
        Callback.mSharedInstance.fetchArticle(accesstoken:mToken,articleId: String(mNewsId)) { (ArticleDetail,code,error) in
            
            if let error = error{
                print("網路連線不良",error)

                self.mTableView.isHidden = true
                
                
                //                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "網路連線不良")
                return
            }
            switch code {
            case 200,201:
                
                if(ArticleDetail != nil){
                    
                    guard let getArticleDetail = ArticleDetail else { return }
                    self.mNewsData.removeAll()
                    self.mNewsData = [getArticleDetail]
                    print("ArticleDetail",self.mNewsData[0])
                    self.mCommentCount = (self.mNewsData[0].comment?.data?.count)!
                    self.mlatestCount = (self.mNewsData[0].latest?.count)!
                    self.mCommentTotal.text = String(self.mNewsData[0].comment_total)
                    print("iskeep",self.mNewsData[0].is_keeped)
                    print("iskeep",self.mNewsData[0].is_liked)

                    if self.mNewsData[0].is_keeped {
                        
                        self.mCommentKeep.setImage(UIImage.init(named: LocalData.KEEP_IMAGE_SELECT), for: .normal)

                        self.mIsKeep = true

                        
                    }else{
                        
                        self.mCommentKeep.setImage(UIImage.init(named: LocalData.KEEP_IMAGE_UNSELECT), for: .normal)

                        self.mIsKeep = false
                    }
                    
                    if self.mNewsData[0].is_liked {
                        
                        self.mCommentLink.setImage(UIImage.init(named: LocalData.LINK_IMAGE_SELECT), for: .normal)

                        self.mIsLink = true
                        
                    }else{
                        
                        self.mCommentLink.setImage(UIImage.init(named: LocalData.LINK_IMAGE_UNSELECT), for: .normal)
                    
                        self.mIsLink = false
                    }
                    
                    self.mTableView.reloadData()
                    self.mTableView.isHidden = false
                    self.mTableView.dataSource = self
                    self.mTableView.delegate = self
          
                }else{
                    
                    
                    
                }
                
            default:
                print("與伺服器連線中斷")
                self.mTableView.isHidden = true
                
                //                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
            
            
        }
        
        
    }
    
    
    func getKeepArticle(){
        
        Callback.mSharedInstance.fetchKeepArticle(accesstoken: mToken, articleId: String(mNewsId)) { (ServerResponse, code, error) in
            
            
            if let error = error{
                print("網路連線不良",error)
        
                return
            }
            switch code {
            case 200,201:
                
                print("成功")
                
            default:
                
                print("與伺服器連線中斷",code)
            
            }
            
            
        }
        
        
    }
    
    func getLinkArticle(){
        
        Callback.mSharedInstance.fetchLikeArticle(accesstoken: mToken, articleId: String(mNewsId)) { (ServerResponse, code, error) in
            
            
            if let error = error{
                print("網路連線不良",error)
                
                return
            }
            switch code {
            case 200,201:
                
                print("成功")
                
            default:
                
                print("與伺服器連線中斷",code)
                
            }
            
            
        }
        
        
    }
    
    func getfetchComment(text:String){
        
//        mTableView.isHidden = true
        Callback.mSharedInstance.fetchCommentList(accesstoken: mToken, articleId: mNewsId, parentId: 0, page: 1, text: text) { (Comment, code, error) in
            
  
            
            if let error = error{
                print("網路連線不良",error)
                
                return
            }
            switch code {
            case 200,201:
                
                if(Comment != nil){
                    
                    guard let getComment = Comment else { return }
                    print("getComment",getComment)
                    self.getfetchArticle()

                }
                
            default:
                print("與伺服器連線中斷")
//                self.mTableView.isHidden = true
                
                //                self.dismiss(animated: true, completion: nil)
                //                self.setSnackbar(mseeage: "與伺服器連線中斷")
            }
            
            
        }
        
        
    }
    
    func getLinkfetchComment(commentId:Int,mMessageLikeBt:UIButton){
        
        //        mTableView.isHidden = true
        Callback.mSharedInstance.fetchLikeComment(accesstoken: mToken,commentId: commentId ) { (ServerResponse, code, error) in
            
            
            
            if let error = error{
                print("網路連線不良",error)
                
                return
            }
            switch code {
            case 200,201:
            
                    guard let getServerResponse = ServerResponse else { return }
                    print("getComment",getServerResponse)
                    self.mIsCommentLink = getServerResponse.message ?? ""
                    print("getComment",self.mIsCommentLink)
                    print("getComment",self.mLinkmessageLb)

                
                    if self.mIsCommentLink == "liked"{
                        
                        mMessageLikeBt.setImage(UIImage.init(named: LocalData.LINK_IMAGE_SELECT), for: .normal)
//                        self.mIsCommentLink = "discard"
                        self.mLinkmessageLb = getServerResponse.total ?? 0
                        mMessageLikeBt.setTitle(String(self.mLinkmessageLb), for: .normal)
                        
                    }else{
                        
                        mMessageLikeBt.setImage(UIImage.init(named: LocalData.LINK_IMAGE_UNSELECT), for: .normal)
//                        self.mIsCommentLink = "liked"
                        self.mLinkmessageLb = getServerResponse.total ?? 0
                        mMessageLikeBt.setTitle(String(self.mLinkmessageLb), for: .normal)
                        
                        
                }

                
                
            default:
                print("與伺服器連線中斷")
                
            }
            
            
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mCommentCount+mlatestCount + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Time = (getNowTimestamp() - mNewsData[0].report_time) / 60 / 60

        
        switch indexPath.item {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingleNewsImageTVC", for: indexPath) as! SingleNewsImageTVC
        
            if (Time <= 0) {
                cell.mSingNewsTime.setTitle("剛剛", for: .normal)
            } else {
                cell.mSingNewsTime.setTitle(String(lroundf(Float(Time)))+"小時前",for: .normal)
            }
            
            if (Time >= 24) {
                
                let timehr = Time/24
                cell.mSingNewsTime.setTitle(String(lroundf(Float(timehr)))+"天前",for: .normal)
                
            }
            
            cell.mSingNewsTitleLb.text = mNewsData[0].title
            cell.mSingNewsInnerLb.text = mNewsData[0].description
            cell.mSingNewsSourceBt.setTitle(mNewsData[0].datasource_name, for: .normal)
            cell.mSingNewsPageViewBt.setTitle(String(mNewsData[0].pageview), for: .normal)
            cell.mSingNewsIv.sd_setImage(with: URL(string: (mNewsData[0].media?[0].small ?? "")),placeholderImage: UIImage(named: "image_null_tw"))



            return cell
        case 1,7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GoogleAdsTVC", for: indexPath) as! GoogleAdsTVC
            cell.mGoogleAdsView.rootViewController = self
            return cell
        case 2,3,4,5,6:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SIngNewsHotTVC", for: indexPath) as! SIngNewsHotTVC
                cell.mHotLb.text = mNewsData[0].latest?[indexPath.row-2].title
                cell.mHotIv.sd_setImage(with: URL(string: (mNewsData[0].latest?[indexPath.row-2].media?.small ?? "")),placeholderImage: UIImage(named: "image_null_tw"))
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SingNewsMessage", for: indexPath) as! SingNewsMessage
            
                    let Time = (getNowTimestamp() - (mNewsData[0].comment?.data?[indexPath.row-8].create_time)!) / 60 / 60
                    
                    if (Time <= 0) {
                        cell.mMessageTime.text = "剛剛"
                    } else {
                        cell.mMessageTime.text = (String(lroundf(Float(Time)))+"小時前")
                    }
                    
                    if (Time >= 24) {
                        
                        let timehr = Time/24
                        cell.mMessageTime.text = (String(lroundf(Float(timehr)))+"天前")
                        
                    }
            
                    mLinkmessageLb = (mNewsData[0].comment?.data?[indexPath.row-8].like_total)!
            

                    cell.mMessageBt.tag = indexPath.row-8
                    cell.mMessageLikeBt.tag = indexPath.row - 8
                    cell.mMessageNameLb.text = mNewsData[0].comment?.data?[indexPath.row-8].user_name
                    cell.mMessageLb.text = mNewsData[0].comment?.data?[indexPath.row-8].text
                    cell.mMessageLikeBt.setTitle(String(mLinkmessageLb), for: .normal)
                    cell.mMessageBt.setTitle("回覆 " + String(mNewsData[0].comment?.data?[indexPath.row-8].comment_total ?? 0), for: .normal)
                    cell.mMessagePhotoIV.sd_setImage(with: URL(string: (mNewsData[0].comment?.data?[indexPath.row-8].user_avatar ?? "")),placeholderImage: UIImage(named: "avatar_initial"))
                    cell.mMessageBt.addTarget(self, action: #selector(MessageBt(_:)), for: .touchUpInside)
                    cell.mMessageLikeBt.addTarget(self, action: #selector(LinkMessageAction(_:)), for: .touchUpInside)

            
                    if (mNewsData[0].comment?.data?[indexPath.row-8].is_liked)! {
                
                        cell.mMessageLikeBt.setImage(UIImage.init(named: LocalData.LINK_IMAGE_SELECT), for: .normal)
                        mIsCommentLink = "liked"
                
                        }else{
                
                        cell.mMessageLikeBt.setImage(UIImage.init(named: LocalData.LINK_IMAGE_UNSELECT), for: .normal)
                        mIsCommentLink = "discard"


                    }


            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row - 2 <= mlatestCount - 1 && indexPath.row != 0 && indexPath.row != 1{
            
            mNewsId = mNewsData[0].latest?[indexPath.row-2].id ?? 0
            print("喔喔", mNewsData[0].latest?[indexPath.row-2].id ?? 0)
            getfetchArticle()
            
        }
    
    }
    
    
    @objc func MessageBt(_ messageBt:UIButton) {

        print("喔喔喔",(mNewsData[0].comment?.data?[messageBt.tag].comment_url) ?? "")
  
    }
    @objc func LinkMessageAction(_ mMessageLikeBt:UIButton) {

        
        let commentid = mNewsData[0].comment?.data?[mMessageLikeBt.tag].comment_id
        getLinkfetchComment(commentId: commentid ?? 0,mMessageLikeBt: mMessageLikeBt)

    }
    



}
