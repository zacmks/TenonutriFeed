//
// Created by Isaac Mitsuaki Saito on 09/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation

typealias FeedItemLoadPageActionCompletionHandler = (_ feedItems: Result<[FeedItem]>) -> Void

protocol FeedLoadPageAction {
    func loadFeedItemsForPageAction(timestamp: Int64, page: Int, completionHandler: @escaping FeedItemLoadPageActionCompletionHandler)
}

class FeedLoadPageActionImpl: FeedLoadPageAction {
    let feedItemManager: FeedItemManager

    init(feedItemManager: FeedItemManager) {
        self.feedItemManager = feedItemManager
    }

    func loadFeedItemsForPageAction(timestamp: Int64, page: Int, completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
        self.feedItemManager.fetchFeedItemsForPage(timestamp: timestamp, page: page) { (result) in
            // Do any additional processing & after that call the completion handler
            completionHandler(result)
        }
    }
}
