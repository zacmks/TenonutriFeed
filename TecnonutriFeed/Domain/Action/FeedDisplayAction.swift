//
// Created by Isaac Mitsuaki Saito on 09/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation

typealias DisplayFeedItemsActionCompletionHandler = (_ feedItems: Result<[FeedItem]>) -> Void

protocol FeedDisplayAction {
    func displayFeedItems(completionHandler: @escaping DisplayFeedItemsActionCompletionHandler)
}

class FeedDisplayActionImpl: FeedDisplayAction {
    let feedItemManager: FeedItemManager

    init(feedItemManager: FeedItemManager) {
        self.feedItemManager = feedItemManager
    }

    func displayFeedItems(completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
        self.feedItemManager.fetchFeedItems { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
