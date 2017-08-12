//
// Created by Isaac Mitsuaki Saito on 09/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentAlert(withTitle title: String, message: String) {
        presentAlert(withTitle: title, message: message, button: NSLocalizedString("Dismiss", comment: ""))
    }

    func presentAlert(withTitle title: String, message: String, button: String) {
        presentAlert(withTitle: title, message: message, button: button, handler: nil)
    }

    func presentAlert(withTitle title: String, message: String, button: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .cancel, handler: handler))
        present(alert, animated: true)
    }
}
