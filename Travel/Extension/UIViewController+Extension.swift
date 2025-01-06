//
//  UIViewController + Extension.swift
//  Travel
//
//  Created by ilim on 2025-01-05.
//

import UIKit

extension UIViewController {
    func presentAlert(message: String?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
