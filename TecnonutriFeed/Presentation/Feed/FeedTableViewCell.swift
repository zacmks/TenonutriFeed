//
//  FeedTableViewCell.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 08/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileGoalLabel: UILabel!
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemDateLabel: UILabel!
    @IBOutlet weak var itemEnergyLabel: UILabel!
    
    @IBOutlet weak var likeButton: LikeButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
