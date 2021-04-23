import UIKit

protocol Presentable where Self: UIViewController {

    var toPresent: UIViewController { get }
}
