

import Foundation

struct LocalData {
    static let accessToken = "accessToken"
    static let refreshToken = "refreshToken"
    static let userId = "userId"
    static let userAccount = "userAccount"
    static let userPassword = "userPassword"
    static let lang = "lang"
    static let isFirstUse = "isFirstUse"
    static let fromWebUrl = "fromWebUrl"
}
func getFromWebUrl() -> String{
    return UserDefaults.standard.string(forKey: LocalData.fromWebUrl)!
}
func setFromWebUrl(fromWebUrl: String){
    UserDefaults.standard.set(fromWebUrl, forKey: LocalData.fromWebUrl)
}
func checkIsFirstUse() -> Bool{
    return UserDefaults.standard.bool(forKey: LocalData.isFirstUse)
}
func setIsFirstUse(isFirstUse: Bool){
    UserDefaults.standard.set(isFirstUse, forKey: LocalData.isFirstUse)
}
func getUserAccount() -> String{
    return UserDefaults.standard.string(forKey: LocalData.userAccount)!
}
func setUserAccount(userAccount: String){
    UserDefaults.standard.set(userAccount, forKey: LocalData.userAccount)
}
func getUserPassword() -> String{
    return UserDefaults.standard.string(forKey: LocalData.userPassword)!
}
func setUserPassword(userPassword: String){
    UserDefaults.standard.set(userPassword, forKey: LocalData.userPassword)
}
func getAccessToken() -> String{
    return UserDefaults.standard.string(forKey: LocalData.accessToken)!
}
func setAccessToken(accessToken: String){
    UserDefaults.standard.set(accessToken, forKey: LocalData.accessToken)
}
func getRefreshToken() -> String{
    return UserDefaults.standard.string(forKey: LocalData.refreshToken)!
}
func setRefreshToken(refreshToken: String){
    UserDefaults.standard.set(refreshToken, forKey: LocalData.refreshToken)
}
func getUserId() -> Int{
    return UserDefaults.standard.integer(forKey: LocalData.userId)
}
func setUserId(userId: Int){
    UserDefaults.standard.set(userId, forKey: LocalData.userId)
}
func getLanguageType() -> String{
    return UserDefaults.standard.string(forKey: LocalData.lang)!
}
func setLanguageType(languageType: String){
    UserDefaults.standard.set(languageType, forKey: LocalData.lang)
}

