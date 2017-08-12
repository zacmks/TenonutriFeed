//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation

typealias FetchFeedItemsEntityManagerCompletionHandler = (_ feedItems: Result<[FeedItem]>) -> Void
typealias FetchFeedItemDetailsEntityManagerCompletionHandler = (_ feedItems: Result<FeedItem>) -> Void

protocol FeedItemManager {
    func fetchFeedItems(completionHandler: @escaping FetchFeedItemsEntityManagerCompletionHandler)
    func fetchFeedItemDetails(feedItem: FeedItem, completionHandler: @escaping FetchFeedItemDetailsEntityManagerCompletionHandler)
    func likeDislikeFeedItem(feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void)
    func fetchFeedItemsForPage(timestamp: Int64, page: Int, completionHandler: @escaping (Result<[FeedItem]>) -> Void)
}

class FeedItemManagerImpl: FeedItemManager {

    let feedItemManagerAPI: FeedItemManagerAPI
    let feedItemManagerDB: FeedItemManagerDB

    init(feedItemManagerAPI: FeedItemManagerAPI, feedItemManagerDB: FeedItemManagerDB) {
        self.feedItemManagerAPI = feedItemManagerAPI
        self.feedItemManagerDB = feedItemManagerDB
    }

    func fetchFeedItems(completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
        feedItemManagerAPI.fetchFeedItems { (result) in
            self.handleFetchFeedItemsApiResult(result, completionHandler: completionHandler)
        }
    }

    fileprivate func handleFetchFeedItemsApiResult(_ result: Result<[FeedItem]>, completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
        switch result {
        case let .success(feedItems):
//            TODO save, maybe
//            feedItemManagerDB.save(feedItems: feedItems)
            completionHandler(result)
        case .failure(_):
            feedItemManagerDB.fetchFeedItems(completionHandler: completionHandler)
            completionHandler(result)
        }
    }

    func fetchFeedItemDetails(feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void) {
        feedItemManagerAPI.fetchFeedItemDetails(feedItem: feedItem) { (result) in
            self.handleFetchFeedItemDetailsApiResult(result, feedItem: feedItem, completionHandler: completionHandler)
        }
    }

    fileprivate func handleFetchFeedItemDetailsApiResult(_ result: Result<FeedItem>, feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void) {
        switch result {
        case let .success(feedItem):
//            TODO save, maybe
//            feedItemManagerDB.save(feedItems: feedItems)
            completionHandler(result)
        case .failure(_):
            feedItemManagerDB.fetchFeedItemDetails(feedItem: feedItem, completionHandler: completionHandler)
            completionHandler(result)
        }
    }

    func likeDislikeFeedItem(feedItem: FeedItem, completionHandler: @escaping (Result<FeedItem>) -> Void) {
        feedItemManagerDB.likeDislikeFeedItem(feedItem: feedItem, completionHandler: completionHandler)
//        completionHandler(completionHandler)
    }


    func fetchFeedItemsForPage(timestamp: Int64, page: Int, completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
        feedItemManagerAPI.fetchFeedItemsForPage(timestamp: timestamp, page: page, completionHandler: completionHandler)
    }
}
