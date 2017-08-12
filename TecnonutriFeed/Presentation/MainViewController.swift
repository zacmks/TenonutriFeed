//
//  MainViewController.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 08/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

class MainViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = Theme.primaryDarkColor
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

