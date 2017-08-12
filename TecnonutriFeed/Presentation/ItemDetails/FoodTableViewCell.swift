//
//  FoodTableViewCell.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 11/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var measureLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var carbohydrateLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
