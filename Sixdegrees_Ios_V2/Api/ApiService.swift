

import Foundation

struct ApiService {
    
    //Api
    
    static let grant_type = "client_credentials"
//    static let client_secret = "ibuM2Bld0rWWz40t8GxpNnI9mhOCQCJy8DJS0il2"
//    static let client_member_secret = "6QlUqYoOSsQ6KbVggH3e30GMaworInyycZGzVq0X"
    static let accept = "application/vnd.sixdegree.v1_1+json"
    static let contentType = "application/x-www-form-urlencoded"
//    static let api = "https://api.six-degrees.io"
    static let bearer = "Bearer "
    static let password = "password"
    static let mClientToken = ApiService.bearer+getString(key: LocalData.CLIENT_TOKEN)
    
    //    測試機
      static  let api = "https://api.dev.sixdegreeworld.com"
        static let client_secret = "zSVE2Bd64icnRyo7VSo997rriPLDPMbY9LmmIurv"
        static let client_member_secret = "yGdNcZJlry89WWJ13cLBOmr0ExPWpmrKv2ap9Crx"
    
    //Api Url
    static let client_token = "/oauth/token"
    static let password_token = "/oauth/token/login"
    static let refresh_token = "/oauth/token/refresh"
    static let category_list = "/navbar"
    static let PopularArticleList = "/article/popular"
    static let RecommendArticleList = "/article/recommend"
    static let register = "/user/register"
    static let forgetPassword = "/user/forgot_password"
    static let facebookLogin = "/user/facebook"
    static let googleLogin = "/user/google"
    static let twitterLogin = "/user/twitter"
    static let YoutubeVideo = "/article/video"
    static let userKeepUrl = "/user/keeped"
    static let userInfo = "/user/info"
    static let artucke = "/article/"
    
    
    
    
    
    
    
    //APi參數
    static let Limt = 50

    
}


