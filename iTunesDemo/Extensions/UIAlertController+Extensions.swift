import UIKit
import Rswift

extension UIAlertController {

    static func errorAlert(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: R.string.localizable.errorTitle(),
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.okTitle(),
                                      style: .default,
                                      handler: nil))
        return alert
    }
}
