//
// Created by Isaac Mitsuaki Saito on 10/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import UIKit

protocol FeedViewSwitcher: ViewSwitcher {
    func presentDetailsView(for feedItem: FeedItem)
}

class FeedViewSwitcherImpl: FeedViewSwitcher {
    fileprivate weak var feedViewController: FeedViewController?
//    TODO
//    fileprivate weak var itemDetailsPresenterDelegate: ItemDetailsPresenterDelegate?
    fileprivate var feedItem: FeedItem!

    init(feedViewController: FeedViewController) {
        self.feedViewController = feedViewController
    }

    func presentDetailsView(for feedItem: FeedItem) {
        self.feedItem = feedItem
//        TODO if we "like the item"
//        self.itemDetailsPresenterDelegate = itemDetailsPresenterDelegate
        feedViewController?.performSegue(withIdentifier: "FeedToItemDetailsSegue", sender: nil)
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //            TODO configure according to the item detail
//        if let itemDetailsViewController = segue.destination as? ItemDetailsViewController {
////            TODO configure according to the item detail
////            itemDetailsViewController.configurator = ItemDetailsConfiguratorImplementation(feedItem: feedItem)
//        }
    }
}
