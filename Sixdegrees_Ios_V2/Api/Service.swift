


import Alamofire
//android : 5fccb26555c7dbcbbad8187e5d084b2b
//​ios : ​​​0cc62e4ffcd083a6fdc153a7ffe1df84
struct Service {
    static let sharedInstance = Service()
    static let grant_type = "client_credentials"
//    測試機
//    static let client_secret = "zSVE2Bd64icnRyo7VSo997rriPLDPMbY9LmmIurv"
//    static let client_member_secret = "yGdNcZJlry89WWJ13cLBOmr0ExPWpmrKv2ap9Crx"
//    測試機
    static let client_secret = "ibuM2Bld0rWWz40t8GxpNnI9mhOCQCJy8DJS0il2"
    static let client_member_secret = "6QlUqYoOSsQ6KbVggH3e30GMaworInyycZGzVq0X"
    static let accept = "application/vnd.sixdegree.v1_0+json"
    static let contentType = "application/x-www-form-urlencoded"
    let api = "https://api.six-degrees.io"
//    測試機
//    let api = "http://api.dev.sixdegreeworld.com"
//    測試機
    //取得一般token OK
    func fetchClientToken( completion: @escaping(Token?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_id"] = 1
        parameters["client_secret"] = Service.client_secret
        Alamofire.request(api + "/oauth/token",method: .post,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetToken.self, from: data)
                    completion(result.data,nil)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
        }
    }
    //取得會員登入token OK
    func fetchMemberToken(useremail:String,password:String, completion: @escaping(Token?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = "password"
        parameters["client_id"] = 2
        parameters["client_secret"] = Service.client_member_secret
        parameters["username"] = useremail
        parameters["password"] = password
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/oauth/token/login",method: .post,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetToken.self, from: data)
                    completion(result.data,nil)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //取得更新token OK
    func fetchRefreshToken( completion: @escaping(Token?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = "refresh_token"
        parameters["client_id"] = 2
        parameters["client_secret"] = Service.client_member_secret
        parameters["refresh_token"] = getRefreshToken()
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/oauth/token/refresh",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetToken.self, from: data)
                    completion(result.data,nil)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
        }
    }
    //取得預設頻道列表 OK
    func fetchDefaultCategoryList( completion: @escaping([Category]?,String?) -> ()){
        var headers : [String:String] = [:]
//        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
//        parameters["grant_type"] = ServiceNew.grant_type
//        parameters["client_id"] = 1
//        parameters["client_secret"] = ServiceNew.client_secret
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/navbar",method: .get,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetCategoryList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得我的頻道列表 OK
    func fetchMyCategoryList( completion: @escaping(MyCategories?,String?) -> ()){
        var headers : [String:String] = [:]
//        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Authorization"] = "Bearer " + getAccessToken()
        headers["Content-Type"] = Service.contentType
//        parameters["grant_type"] = ServiceNew.grant_type
//        parameters["client_id"] = 1
//        parameters["client_secret"] = ServiceNew.client_secret
//        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/navbar/show",method: .get,headers: headers).responseJSON { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetMyCategory.self, from: data)
                    //                guard let categoryArray = result.data else { return }
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    
    //修改我的頻道列表 OK
    func fetchModifyMyCategoryList(tagArray:String, completion: @escaping([Category]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        parameters["grant_type"] = Service.grant_type
        parameters["client_id"] = 1
        parameters["client_secret"] = Service.client_secret
        headers["Content-Type"] = Service.contentType
        parameters["tag_id"] = tagArray
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/navbar/update",method: .post,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetCategoryList.self, from: data)
                    //                guard let categoryArray = result.data else { return }
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //新增我的頻道列表
//    func fetchAddMyCategoryList(tagId:String, completion: @escaping([Category]?,String?) -> ()){
//        var headers : [String:String] = [:]
//        var parameters: [String: Any] = [:]
//        headers["Accept"] = ServiceNew.accept
//        parameters["grant_type"] = ServiceNew.grant_type
//        parameters["client_id"] = 1
//        parameters["client_secret"] = ServiceNew.client_secret
//        headers["Content-Type"] = ServiceNew.contentType
//        parameters["tag_id"] = tagId
//        headers["Authorization"] = "Bearer " + getAccessToken()
//        Alamofire.request(api + "/navbar/insert",method: .post,parameters: parameters,headers: headers).responseData { (response) in
//            if let error = response.error{
//                print("Failed to connect server :",error)
//                completion(nil,error.localizedDescription)
//                return
//            }
//            guard let data = response.data else { return }
//            do{
//                let result = try JSONDecoder().decode(GetCategoryList.self, from: data)
//                //                guard let categoryArray = result.data else { return }
//                completion(result.data,nil)
//                print("Fetch Default Category List successfully.")
//
//            }catch let error{
//                completion(nil,error.localizedDescription)
//            }
//        }
//    }
//
//    取得最新全部文章
    func fetchLatestArticleList(page:Int,limit:Int, completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
//        parameters["grant_type"] = Service.grant_type
//        parameters["client_secret"] = Service.client_secret
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/latest",method: .get,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //取得熱門文章 OK
    func fetchPopularArticleList(page:Int,limit:Int,timetype:String, completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["page"] = page
        parameters["limit"] = limit
        parameters["timetype"] = timetype
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/popular",method: .get,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得推薦文章 OK
    func fetchRecommendArticleList(page:Int,limit:Int, completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/recommend",method: .get,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得視頻文章 OK
    func fetchVideoList(page:Int,limit:Int, completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/video",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //收藏文章 OK
    func fetchKeepArticle(articleId:String, completion: @escaping(ServerResponse?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["article_id"] = articleId
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/keep",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //按讚文章  OK
    func fetchLikeArticle(articleId:String, completion: @escaping(ServerResponse?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["article_id"] = articleId
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/like",method: .post,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得單一文章 OK
    func fetchArticle(articleId:String, completion: @escaping(ArticleDetail?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/" + articleId ,method: .get,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticle.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得新聞留言列表
    func fetchCommentList(articleId:Int,parentId:Int?,page: Int?,limit:Int, completion: @escaping([Comment]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["article_id"] = articleId
        parameters["parent_id"] = parentId
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/comment",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetComments.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //新增留言 OK
    func fetchAddComment(articleId:String,parentId:Int?,text:String, completion: @escaping(ServerResponse?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["article_id"] = articleId
        parameters["parent_id"] = parentId
        parameters["text"] = text
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/comment",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //刪除留言
    func fetchDeleteComment(articleId:Int,commentId:Int, completion: @escaping(ServerResponse?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["article_id"] = articleId
        parameters["comment_id"] = commentId
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/comment",method: .delete,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    
    //按讚留言 OK
    func fetchLikeComment(commentId:Int, completion: @escaping(ServerResponse?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["comment_id"] = commentId
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/article/comment/like",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得全部標籤
    func fetchTagList( completion: @escaping([Category]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/tag",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetCategoryList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //根據url取得文章列表 OK
    func fetchArticleListFromURL(url:String,page:Int,limit:Int,completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
//        parameters["grant_type"] = ServiceNew.grant_type
//        parameters["client_secret"] = ServiceNew.client_secret
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(url,method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //取得標籤文章列表
    func fetchTagArticleList(tagId:String,page:Int,limit:Int, completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/tag" + tagId + "/article",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //取得按讚文章列表  OK
    func fetchLikedArticleList(type:Int,userId:Int?,page:Int,limit:Int, completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["type"] = type
        parameters["user_id"] = userId
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/liked",method: .get,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
        }
    }
    //取得瀏覽過的文章列表 OK
    func fetchViewedArticleList(userId:String?,page:Int,limit:Int, completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["user_id"] = userId
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/viewed",method: .get,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
        }
    }
    //取得所有新聞來源
    func fetchDatasourceList( completion: @escaping([ArticleDatasource]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/datasource",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetDatasourceList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得單一新聞來源
    func fetchDatasource(datasourceId:String, completion: @escaping(ArticleDatasource?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/datasource" + datasourceId ,method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetDatasource.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //根據新聞來源取得新聞列表
    func fetchArticleListFromDatasource(datasourceId:String,page:Int,limit:Int, completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/datasource" + datasourceId + "/article",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得搜尋字串的文章列表 OK
    func fetchSearchArticleList(searchText:String, completion: @escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["name"] = searchText
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/search",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //取得熱門搜尋字串的文章列表 OK
    func fetchSearchPopularCategoryList( completion: @escaping([Category]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/search/popular",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetCategoryList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //取得歷史搜尋字串的文章列表
    func fetchSearchHistoryCategoryList( completion: @escaping([Category]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/search/history",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetCategoryList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //會員註冊 OK
    func fetchMemberRegister(email:String,password:String,name:String, completion: @escaping(Token?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["email"] = email
        parameters["password"] = password
        parameters["name"] = name
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/register",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetToken.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //Facebook登入/註冊 OK
    func fetchFacebook(email:String,facebookId:String,name:String, completion: @escaping(Token?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Content-Type"] = Service.contentType
        parameters["email"] = email
        parameters["facebook_id"] = facebookId
        parameters["name"] = name
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/facebook",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
//            print(response.result.value)
//            print("fetch facebook succssfully.")
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetToken.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //Google登入/註冊 OK
    func fetchGoogle(email:String,googleId:String,name:String, completion: @escaping(Token?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Content-Type"] = Service.contentType
        parameters["email"] = email
        parameters["google_id"] = googleId
        parameters["name"] = name
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/google",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
//            print("fetch google successfully")
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetToken.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //Twitter登入/註冊 OK
    func fetchTwitter(email:String,twitterId:String,name:String, completion: @escaping(Token?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Content-Type"] = Service.contentType
        parameters["email"] = email
        parameters["twitter_id"] = twitterId
        parameters["name"] = name
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/twitter",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
//            print("fetch google successfully")
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetToken.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //忘記密碼
    func fetchForgotPassword(email:String, completion: @escaping(ServerResponse?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Content-Type"] = Service.contentType
        headers["Accept"] = Service.accept
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["email"] = email
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/forgot_password",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得自己的會員資料 OK
    func fetchMemberInfo( completion: @escaping(User?,String?) -> ()){
        var headers : [String:String] = [:]
//        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
//        parameters["grant_type"] = Service.grant_type
//        parameters["client_secret"] = Service.client_secret
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/info",method: .get,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetMember.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //更新會員資料 OK
    func fetchUpdateMemberInfo(email:String,password:String?,name:String,gender:Int,birthday:String?,description:String? , completion: @escaping(ServerResponse?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        parameters["email"] = email
        parameters["name"] = name
        parameters["gender"] = gender
        parameters["birthday"] = birthday
        parameters["description"] = description
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/info",method: .post,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //會員登出
    func fetchMemberLogout( completion: @escaping(ServerResponse?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Content-Type"] = Service.contentType
        headers["Accept"] = Service.accept
        parameters["grant_type"] = Service.grant_type
        parameters["client_secret"] = Service.client_secret
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/logout",method: .post,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //打賞 OK
    func fetchDonate(targetId:String,amount:Int, completion: @escaping(Bool?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Content-Type"] = Service.contentType
        headers["Accept"] = Service.accept
        parameters["target_id"] = targetId
        parameters["amount"] = amount
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/reward", method: .post, parameters: parameters, headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
//                do{
//                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
//                    completion(result.data?.status,nil)
//
//                }catch let error{
//                    completion(nil,error.localizedDescription)
//                }
                completion(true,nil)
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //取得別人的會員資料 OK
    func fetchOtherMemberInfo(userId:String, completion: @escaping(User?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["user_id"] = userId
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/member",method: .get,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetMember.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //信箱驗證
    func fetchVerifyEmail(code:String, completion: @escaping( ServerResponse?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["code"] = code
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/verification",method: .post, parameters: parameters).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetStatus.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //取得個人收藏列表 OK
    func fetchUserKeepList(userId:Int?,page:Int,limit:Int, completion:@escaping([Article]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["user_id"] = userId
        parameters["page"] = page
        parameters["limit"] = limit
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/keeped",method: .get,parameters: parameters,headers: headers).responseData { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetArticleList.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    //取得個人留言列表 OK
    func fetchUserCommentList(userId:Int?,page:Int,limit:Int, completion: @escaping([CommentAndArticle]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["limit"] = limit
        parameters["page"] = page
        parameters["user_id"] = userId
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/commented",method: .get,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetCommentAndArticle.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
    
    //取得打賞列表 OK
    func fetchDonateList(page:Int,limit:Int, completion: @escaping([DonateDetail]?,String?) -> ()){
        var headers : [String:String] = [:]
        var parameters: [String: Any] = [:]
        headers["Accept"] = Service.accept
        headers["Content-Type"] = Service.contentType
        parameters["limit"] = limit
        parameters["page"] = page
        headers["Authorization"] = "Bearer " + getAccessToken()
        Alamofire.request(api + "/user/reward_history",method: .get,parameters: parameters,headers: headers).responseString { (response) in
            if let error = response.error{
                completion(nil,error.localizedDescription)
                return
            }
            guard let data = response.data else { return }
            if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                do{
                    let result = try JSONDecoder().decode(GetDonateDetail.self, from: data)
                    completion(result.data,nil)
                    
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }else{
                do{
                    let result = try JSONDecoder().decode(GetError.self, from: data)
                    completion(nil,result.error.message)
                }catch let error{
                    completion(nil,error.localizedDescription)
                }
            }
            
        }
    }
}

