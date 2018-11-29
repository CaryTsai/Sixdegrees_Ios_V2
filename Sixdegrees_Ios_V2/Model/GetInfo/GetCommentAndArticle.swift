

struct GetCommentAndArticle:Decodable {
    let success: Bool
    let status_code: Int
    let error: [ErrorMessage]?
    let data: [CommentAndArticle]?
    let pagination: Pagination?
}
