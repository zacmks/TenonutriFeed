//
//  LikeButton.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 11/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

class LikeButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.adjustsImageWhenHighlighted = true
        self.addTarget(self, action: #selector(selectDeselect), for: .touchUpInside)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6,
                options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        super.touchesBegan(touches, with: event)
    }

    func selectDeselect() {
        self.isSelected = !self.isSelected
    }
}
