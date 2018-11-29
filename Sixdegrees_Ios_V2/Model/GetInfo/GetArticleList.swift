




struct GetArticleList:Decodable {
    let success: Bool
    let status_code: Int
    let error: [ErrorMessage]?
    let data: [Article]?
    let pagination: Pagination?
}
