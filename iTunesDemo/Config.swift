import Rswift

struct Config  {
    
    static var baseURL: String {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
            fatalError(R.string.localizable.baseURLLoadingErrorMessage())
        }
        return baseURL
    }
}
