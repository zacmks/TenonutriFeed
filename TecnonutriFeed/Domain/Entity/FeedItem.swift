//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import RealmSwift

class FeedItem: Object {
    dynamic var feedHash: String!
    dynamic var id = 0
    dynamic var meal = 0  // 0=Café da Manhã, 1=Lanche da Manhã, 2=Almoço, 3=Lanche da Tarde, 4=Jantar, 5=Ceia, 6=Pré-Treino, 7=Pós-Treino
    dynamic var date: String!
    dynamic var profile: Profile!

//    dynamic var liked = false
//    dynamic var likes_count = 0
//    dynamic var comments_count = 0
    dynamic var image: String!
//    dynamic var comment: String!
//    dynamic var place: String!
//    dynamic var address: String!
    dynamic var energy: Double = 0.0
    dynamic var carbohydrate: Double = 0.0
    dynamic var fat: Double = 0.0
    dynamic var protein: Double = 0.0
//    dynamic var fat_trans: Double = 0.0
//    dynamic var fat_sat: Double = 0.0
//    dynamic var fiber: Double = 0.0
//    dynamic var sugar: Double = 0.0
//    dynamic var sodium: Double = 0.0
//    dynamic var calcium: Double = 0.0
//    dynamic var iron: Double = 0.0
//    dynamic var moderation: Double = 0.0
//    dynamic var badge:
//    dynamic var locale: String!
    dynamic var local_liked = false

    override static func primaryKey() -> String? {
        return "id"
    }
}