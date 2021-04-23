import UIKit

extension UIViewController {

    func showError(with message: String) {
        let alert = UIAlertController.errorAlert(with: message)
        present(alert, animated: true, completion: nil)
    }
}
