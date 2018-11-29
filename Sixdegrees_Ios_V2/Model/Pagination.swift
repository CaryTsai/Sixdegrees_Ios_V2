



struct Pagination : Decodable{
    let total: Int
    let per_page: Int
    let current_page: Int
    let last_page: Int
    let next_page_url: String?
    let prev_page_url: String?
}
