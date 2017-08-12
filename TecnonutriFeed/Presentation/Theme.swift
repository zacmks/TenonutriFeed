//
//  ThemeASDF.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 12/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import UIKit

struct Theme {

#if THEME_CYAN
    static let primaryColor = UIColor(red: 0.16, green: 0.71, blue: 0.96, alpha: 1.0)
    static let primaryDarkColor = UIColor(red: 0.01, green: 0.53, blue: 0.82, alpha: 1.0)
    static let primaryLightColor = UIColor(red: 0.70, green: 0.90, blue: 0.99, alpha: 1.0)
#else
    static let primaryColor = UIColor(red: 1.00, green: 0.65, blue: 0.15, alpha: 1.0)
    static let primaryDarkColor = UIColor(red: 0.96, green: 0.49, blue: 0.00, alpha: 1.0)
    static let primaryLightColor = UIColor(red: 1.00, green: 0.88, blue: 0.70, alpha: 1.0)
#endif

}
