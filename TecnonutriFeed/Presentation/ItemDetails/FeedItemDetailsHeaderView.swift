//
//  FeedItemDetailsHeaderView.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 10/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

class FeedItemDetailsHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileGoalLabel: UILabel!
    @IBOutlet weak var itemImage: UIImageView!

    @IBOutlet weak var likeButton: LikeButton!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "FeedItemDetailsHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
