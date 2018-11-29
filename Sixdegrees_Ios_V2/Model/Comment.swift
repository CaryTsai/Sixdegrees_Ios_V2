

struct Comment : Decodable{
    let article_id: Int?
    let comment_id: Int
    let user_id: Int?
    let user_name: String?
    let user_avatar: String?
    let text: String?
    let create_time: Double?
    let is_liked: Bool?
    let deletable: Bool?
    let like_total: Int?
    let comment_total: Int?
    let comment_url: String?
}
