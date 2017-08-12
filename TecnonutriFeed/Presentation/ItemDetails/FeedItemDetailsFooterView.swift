//
//  FeedItemDetailsFooterView.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 10/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

class FeedItemDetailsFooterView: UITableViewHeaderFooterView {

    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var carbohydrateLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!

    @IBOutlet weak var topView: UIView!
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "FeedItemDetailsFooterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
