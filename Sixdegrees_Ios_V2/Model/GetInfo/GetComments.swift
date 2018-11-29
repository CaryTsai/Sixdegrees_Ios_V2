


struct GetComments:Decodable {
    let success: Bool?
    let status_code: Int?
    let error: [ErrorMessage]?
    let data: [Comment]?
    let pagination: Pagination?
}
