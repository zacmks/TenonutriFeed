//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import RealmSwift

class Profile: Object {
    dynamic var id = 0
    dynamic var name: String!
    dynamic var image: String!
    dynamic var general_goal: String!
//    dynamic var following = false;
//    dynamic var badge:
//    dynamic var locale: String!
//    dynamic var items_count = 0
//    dynamic var followers_count = 0
//    dynamic var followings_count = 0

    override static func primaryKey() -> String? {
        return "id"
    }
}