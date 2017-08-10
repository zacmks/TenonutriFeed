//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import RealmSwift

class FeedItemManagerDB: FeedItemManager {

    func fetchFeedItems(completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
//        TODO timestamp
        let realm = try! Realm()
        completionHandler(.success(Array(realm.objects(FeedItem.self))))
//        completionHandler(.failure(response.result.error!))
    }
}