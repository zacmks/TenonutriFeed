//
// Created by Isaac Mitsuaki Saito on 09/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

extension UIViewController {

    func presentAlert(withTitle title:String, message: String) {
//        TODO translation
        presentAlert(withTitle: title, message: message, button: "Dismiss")
    }

    func presentAlert(withTitle title:String, message: String, button: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
