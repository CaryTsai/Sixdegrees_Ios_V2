


struct GetDonateDetail:Decodable {
    let success: Bool
    let status_code: Int
    let error: [ErrorMessage]?
    let data: [DonateDetail]?
    let pagination: Pagination?
}
