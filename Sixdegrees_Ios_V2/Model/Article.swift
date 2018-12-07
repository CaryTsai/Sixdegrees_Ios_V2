



struct Article : Decodable{
    let id: Int
    let title: String
    let description: String?
    let content: String?
    let datasource_id: Int
    let datasource_name: String
    let news_url: String
    let video_url: String?
    let pageview: Int
    let partial: Int?
    let report_time: Double
    let share_url: String?
    let comment_total: Int
    let like_total: Int?
    let is_liked: Bool?
    let is_keeped: Bool?
    let media: MediaImage?
    let tag: [Category]?
}
