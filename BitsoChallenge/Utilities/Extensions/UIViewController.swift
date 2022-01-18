//
//  UIViewController.swift
//  BitsoChallenge
//
//  Created by Diego Quimbo on 4/25/21.
//

import UIKit

extension UIViewController {
    
    func showProgressView(view: UIView) {
        ProgressView.shared.showProgress(to: view)
    }
    
    func hideProgressView() {
        ProgressView.shared.hideProgress()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
