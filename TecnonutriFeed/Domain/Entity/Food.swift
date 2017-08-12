//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import RealmSwift

class Food: Object {
    dynamic var _description: String!
    dynamic var measure: String!
    dynamic var amount: Double = 0.0
    dynamic var weight: Double = 0.0
    dynamic var energy: Double = 0.0
    dynamic var carbohydrate: Double = 0.0
    dynamic var fat: Double = 0.0
    dynamic var protein: Double = 0.0
}