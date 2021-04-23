import Rswift

struct Config  {
    
    static var baseURL: String {
        let baseUrlKey = R.string.localizable.baseURLKey()
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: baseUrlKey) as? String else {
            fatalError(R.string.localizable.baseURLLoadingErrorMessage())
        }
        return baseURL
    }
}
