//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import RealmSwift

class FeedItem: Object {

    dynamic var t: Int64 = 0
    dynamic var p = 0

    dynamic var feedHash: String?
    dynamic var id = 0
    dynamic var meal = 0  // 0=Café da Manhã, 1=Lanche da Manhã, 2=Almoço, 3=Lanche da Tarde, 4=Jantar, 5=Ceia, 6=Pré-Treino, 7=Pós-Treino
    dynamic var date: String?
    dynamic var profile: Profile?
    dynamic var image: String?
    dynamic var energy: Double = 0.0
    dynamic var carbohydrate: Double = 0.0
    dynamic var fat: Double = 0.0
    dynamic var protein: Double = 0.0

    dynamic var local_liked = false
    let foods = List<Food>()

    override static func primaryKey() -> String? {
        return "id"
    }
}