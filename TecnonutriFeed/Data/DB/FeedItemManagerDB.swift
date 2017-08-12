//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import RealmSwift

class FeedItemManagerDB: FeedItemManager {

    func fetchFeedItems(completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
        let realm = try! Realm()
        let feedItems = realm.objects(FeedItem.self)
        let maxTimestamp = feedItems.max(ofProperty: "t") as Int64?
        let predicate = NSPredicate(format: "t = %d", maxTimestamp!)
        completionHandler(.success(Array(realm.objects(FeedItem.self).filter(predicate))))
        //        TODO error
//        completionHandler(.failure(response.result.error!))
    }

    func fetchFeedItemsForPage(timestamp: Int64, page: Int, completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
    }

    func fetchFeedItemDetails(feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void) {
        do {
            let realm = try Realm()
            if let feedHash = feedItem.feedHash {
                let predicate = NSPredicate(format: "feedHash = %@", feedHash)
                let feedItem = try realm.objects(FeedItem.self).filter(predicate).first as! FeedItem
                completionHandler(.success(feedItem))
            } else {
                let error = NSError(domain: "DB error, feed hash not found", code: 1)
                completionHandler(.failure(error))
            }
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
    }


    func likeDislikeFeedItem(feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                feedItem.local_liked = !feedItem.local_liked
            }
            completionHandler(.success(feedItem))
        } catch let error as NSError {
            completionHandler(.failure(error))
        }
    }
}