//
//  UIViewController+ShowErrorAlert.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 04.03.2021.
//

import UIKit

extension UIViewController {
    
    func showError(with message: String) {
        let alert = UIAlertController.errorAlert(with: message)
        present(alert, animated: true, completion: nil)
    }
}
