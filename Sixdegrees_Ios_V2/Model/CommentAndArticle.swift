

struct CommentAndArticle : Decodable{
    let article_id: Int
    let comment_id: Int
    let user_id: Int
    let user_name: String
    let user_avatar: String?
    let text: String
    let create_time: Double
    let deletable: Bool
    let article: Article
}
