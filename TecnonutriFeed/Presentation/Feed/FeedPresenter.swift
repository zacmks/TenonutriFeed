//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import RealmSwift
import YYWebImage

protocol FeedView: class {
    func refreshFeedView()
    func loadFeedViewPage(page: Int)

    func displayFeedLoadError(title: String, message: String)
}

protocol FeedPresenter {
    var numberOfFeedItems: Int { get }
    var switcher: FeedViewSwitcher { get }
    func viewDidLoad()
    func configure(cell: FeedTableViewCell, forRow row: Int)
    func didSelect(row: Int)
}

class FeedPresenterImpl: FeedPresenter {

    fileprivate weak var view: FeedView!
    fileprivate let feedDisplayAction: FeedDisplayAction
    internal let switcher: FeedViewSwitcher

    var feedItems = [FeedItem]()
    var numberOfFeedItems: Int {
        return feedItems.count
    }

    init(view: FeedView, feedDisplayAction: FeedDisplayAction, switcher: FeedViewSwitcher) {
        self.view = view
        self.feedDisplayAction = feedDisplayAction
        self.switcher = switcher
    }

    func viewDidLoad() {
        self.feedDisplayAction.displayFeedItems { (result) in
            switch result {
            case let .success(feedItems):
                self.handleFeedItemsReceived(feedItems)
            case let .failure(error):
                self.handleFeedItemsError(error)
            }
        }
    }

    fileprivate func handleFeedItemsReceived(_ feedItems: [FeedItem]) {
        self.feedItems = feedItems
        view?.refreshFeedView()
    }

    fileprivate func handleFeedItemsError(_ error: Error) {
        // Here we could check the error code and display a localized error message
//        TODO
//        view?.displayFeedItemsRetrievalError(title: "Error", message: error.localizedDescription)
    }

    func refreshFeedView() {
//        TODO reload instead?
//        <#code#>
        view?.refreshFeedView()
    }



    func didSelect(row: Int) {
        let feedItem = feedItems[row]
        switcher.presentDetailsView(for: feedItem)
    }

    func configure(cell: FeedTableViewCell, forRow row: Int) {
        let feedItem = feedItems[row] as FeedItem

        cell.profileNameLabel.text = feedItem.profile.name
        cell.profileGoalLabel.text = feedItem.profile.general_goal
//        TODO translation
        cell.itemDateLabel.text = "Refeição de: \(feedItem.date)"
        cell.itemEnergyLabel.text = "\(feedItem.energy) kcal"

        cell.profileImage.layer.cornerRadius = cell.profileImage.bounds.size.width / 2.0;
        if feedItem.profile.image != nil {
            cell.profileImage.backgroundColor = UIColor.lightGray
            cell.profileImage.yy_setImage(with: URL(string: feedItem.profile.image), options: YYWebImageOptions.setImageWithFadeAnimation)
        } else {
            cell.profileImage.backgroundColor = UIColor.white
            cell.profileImage.image = UIImage(named: "profile")
        }

        if feedItem.image != nil {
            cell.itemImage.yy_setImage(with: URL(string: feedItem.image), options: YYWebImageOptions.setImageWithFadeAnimation)
        }
    }
}
