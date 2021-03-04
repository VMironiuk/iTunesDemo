//
//  UIAlertController+Extensions.swift
//  iTunesDemo
//
//  Created by Vladimir Mironiuk on 04.03.2021.
//

import UIKit

extension UIAlertController {
    
    static func errorAlert(with message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
}
