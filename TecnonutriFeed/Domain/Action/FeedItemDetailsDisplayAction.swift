//
// Created by Isaac Mitsuaki Saito on 09/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation

typealias FeedItemDisplayDetailsActionCompletionHandler = (_ feedItems: Result<FeedItem>) -> Void

protocol FeedItemDetailsDisplayAction {
    func displayFeedItemDetails(feedItem: FeedItem, completionHandler: @escaping FeedItemDisplayDetailsActionCompletionHandler)
}

class FeedItemDetailsDisplayActionImpl: FeedItemDetailsDisplayAction {
    let feedItemManager: FeedItemManager

    init(feedItemManager: FeedItemManager) {
        self.feedItemManager = feedItemManager
    }

    func displayFeedItemDetails(feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void) {
        self.feedItemManager.fetchFeedItemDetails(feedItem: feedItem) { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
