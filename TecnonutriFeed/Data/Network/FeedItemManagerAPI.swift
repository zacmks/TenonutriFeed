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
                let timestamp = json["t"] as? Int64
                let page = json["p"] as? Int
                if let items = json["items"] as? [[String: Any]] {
                    let realm = try! Realm()
                    try! realm.write {
                        for item in items {
                            let feedItem = realm.create(FeedItem.self, value: item, update: true)
                            feedItem.t = timestamp!
                            feedItem.p = page!
                        }
                    }
                    let predicate = NSPredicate(format: "t = %d AND p = %d", timestamp!, page!)
                    let feedItems = realm.objects(FeedItem.self).filter(predicate)
                    completionHandler(.success(Array(feedItems)))
                }
            } else {
                completionHandler(.failure(response.result.error!))
            }
        }
    }

    func fetchFeedItemsForPage(timestamp: Int64, page: Int, completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
        Alamofire.request("\(ApiClient.apiURLString)feed/?p=\(page)&t=\(timestamp)").responseJSON { response in
            if let json = response.result.value as? [String: Any] {
                if let items = json["items"] as? [[String: Any]] {
                    let realm = try! Realm()
                    try! realm.write {
                        for item in items {
                            let feedItem = realm.create(FeedItem.self, value: item, update: true)
                            feedItem.t = timestamp
                            feedItem.p = page
                        }
                    }
                    let predicate = NSPredicate(format: "t = %d AND p = %d", timestamp, page)
                    let feedItems = realm.objects(FeedItem.self).filter(predicate)
                    completionHandler(.success(Array(realm.objects(FeedItem.self))))
                }
            } else {
                completionHandler(.failure(response.result.error!))
            }
        }
    }

    func fetchFeedItemDetails(feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void) {
        Alamofire.request("\(ApiClient.apiURLString)feed/\(feedItem.feedHash!)").responseJSON { response in
            if let error = response.result.error {
                completionHandler(.failure(error))
                return
            }
            if let json = response.result.value as? [String: Any] {
                if let item = json["item"] as? [String: Any] {
                    do {
                        let realm = try Realm()
                        try realm.write {
//                        Includes for old/new foods
                            realm.delete(feedItem.foods)
                            let feedItem = realm.create(FeedItem.self, value: item, update: true)
                            if let foods = item["foods"] as? [[String: Any]] {
                                for (i, food) in foods.enumerated() {
                                    if let description = food["description"] as? String {
                                        feedItem.foods[i]._description = description
                                    }
                                }
                            }
                            completionHandler(.success(feedItem))
                            return
                        }
                    } catch let error as NSError {
                        completionHandler(.failure(error))
                        return
                    }
                }
            }
            if !response.result.isSuccess {
                let error = NSError(domain: NSLocalizedString("Error fetching Feed Item details",
                        comment: "FeedItemManagerAPI.fetchFeedItemDetails"),
                        code: Constants.Error.Data.FetchFeedItemDetails)
                completionHandler(.failure(error))
            }
        }
    }

//    No implementation, currently, we are using only DB
    func likeDislikeFeedItem(feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void) {

    }
}
