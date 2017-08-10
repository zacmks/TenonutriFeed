//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation

typealias FetchFeedItemsEntityManagerCompletionHandler = (_ feedItems: Result<[FeedItem]>) -> Void
// TODO LIKE
//typealias AddBookEntityGatewayCompletionHandler = (_ books: Result<Book>) -> Void
//typealias DeleteBookEntityGatewayCompletionHandler = (_ books: Result<Void>) -> Void

protocol FeedItemManager {
    func fetchFeedItems(completionHandler: @escaping FetchFeedItemsEntityManagerCompletionHandler)
//    TODO LIKE
//    func add(parameters: AddBookParameters, completionHandler: @escaping AddBookEntityGatewayCompletionHandler)
//    func delete(book: Book, completionHandler: @escaping DeleteBookEntityGatewayCompletionHandler)
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
            self.handleFetchBooksApiResult(result, completionHandler: completionHandler)
        }
    }

    fileprivate func handleFetchBooksApiResult(_ result: Result<[FeedItem]>, completionHandler: @escaping (Result<[FeedItem]>) -> Void) {
        switch result {
        case let .success(feedItems):
//            TODO save
//            feedItemManagerDB.save(books: books)
            completionHandler(result)
        case .failure(_):
            feedItemManagerDB.fetchFeedItems(completionHandler: completionHandler)
        }
    }


}

