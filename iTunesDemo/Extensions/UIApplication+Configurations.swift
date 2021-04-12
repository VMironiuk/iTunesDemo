import UIKit

extension UIApplication {
    
    var baseURL: String {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
            fatalError("Cannot get base URL")
        }
        return baseURL
    }
}
