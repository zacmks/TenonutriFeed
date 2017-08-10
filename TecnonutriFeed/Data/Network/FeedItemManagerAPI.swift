//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class FeedItemManagerAPI: FeedItemManager {

    func fetchFeedItems(completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
        Alamofire.request("\(ApiClient.apiURLString)feed/").responseJSON { response in
            if let json = response.result.value as? [String: Any] {
//                TODO timestamp logic
                if let items = json["items"] as? [[String: Any]] {
                    let realm = try! Realm()
                    try! realm.write {
                        for item in items {
                            realm.create(FeedItem.self, value: item, update: true)
                            print(item)
                        }
                    }
                    completionHandler(.success(Array(realm.objects(FeedItem.self))))
                }
            } else {
                completionHandler(.failure(response.result.error!))
            }
        }
    }
}
