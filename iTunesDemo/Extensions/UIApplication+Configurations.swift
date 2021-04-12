import UIKit
import Rswift

extension UIApplication {
    
    var baseURL: String {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
            fatalError(R.string.localizable.baseURLLoadingErrorMessage())
        }
        return baseURL
    }
}
