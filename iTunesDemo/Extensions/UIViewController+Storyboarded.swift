import UIKit

protocol Storyboarded where Self: UIViewController {

    static func instantiateFromStoryboard(_ storyboard: UIStoryboard) -> Self
}

extension UIViewController: Storyboarded {

    static func instantiateFromStoryboard(_ storyboard: UIStoryboard) -> Self {
        storyboard.instantiateViewController(identifier: String(describing: self))
    }
}
