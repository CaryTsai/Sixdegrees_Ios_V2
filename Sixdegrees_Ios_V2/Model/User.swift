



struct User : Decodable{
    let id: Int
    var name: String
    let email: String?
    var description: String?
    let avatar: String?
    let facebook_id: String?
    let twitter_id: String?
    let google_id: String?
    var gender: Int?
    var birthday: String?
    let point: Int?
    let code: String?
    let inviter: String?
    let inviter_id: Int?
}
