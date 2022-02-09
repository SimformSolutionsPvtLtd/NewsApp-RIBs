//
//  ShowAlert.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 05/02/22.
//

import UIKit

extension UIViewController {

    func showErrorAlert(with message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title:  R.string.localization.err(),
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.localization.ok(),
                                          style: .default))
            self.present(alert, animated: true)
        }
    }
}
