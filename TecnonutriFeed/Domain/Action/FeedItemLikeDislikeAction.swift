//
// Created by Isaac Mitsuaki Saito on 09/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation

typealias FeedItemLikeDislikeActionCompletionHandler = (_ feedItems: Result<FeedItem>) -> Void

protocol FeedItemLikeDislikeAction {
    func likeDislikeFeedItem(feedItem: FeedItem, completionHandler: @escaping FeedItemLikeDislikeActionCompletionHandler)
}

class FeedItemLikeDislikeActionImpl: FeedItemLikeDislikeAction {
    let feedItemManager: FeedItemManager

    init(feedItemManager: FeedItemManager) {
        self.feedItemManager = feedItemManager
    }

    func likeDislikeFeedItem(feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void) {
        self.feedItemManager.likeDislikeFeedItem(feedItem: feedItem) { (result) in
            completionHandler(result)
        }
    }
}
