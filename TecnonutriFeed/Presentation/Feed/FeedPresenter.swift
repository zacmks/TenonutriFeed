//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import RealmSwift
import YYWebImage

protocol FeedView: class {
    func refreshFeedView()
    func displayError(title: String, message: String)
}

protocol FeedPresenter {
    var numberOfFeedItems: Int { get }
    var switcher: FeedViewSwitcher { get }
    func viewDidLoad()
    func loadData()
    func configure(cell: FeedTableViewCell, forRow row: Int)
    func didSelect(section: Int)
    func loadNextPage()
}

class FeedPresenterImpl: FeedPresenter {

    fileprivate weak var view: FeedView!
    fileprivate let feedDisplayAction: FeedDisplayAction
    fileprivate let feedLoadPageAction: FeedLoadPageAction
    fileprivate let feedItemLikeDislikeAction: FeedItemLikeDislikeAction
    internal let switcher: FeedViewSwitcher

    var feedItems = [FeedItem]()
    var timestamp: Int64 = 0
    var page: Int = 0
    var isLoadingPage = false

    var numberOfFeedItems: Int {
        return feedItems.count
    }

    init(view: FeedView,
         feedDisplayAction: FeedDisplayAction,
         feedLoadPageAction: FeedLoadPageAction,
         feedItemLikeDislikeAction: FeedItemLikeDislikeAction,
         feedViewSwitcher: FeedViewSwitcher) {
        self.view = view
        self.feedDisplayAction = feedDisplayAction
        self.feedLoadPageAction = feedLoadPageAction
        self.feedItemLikeDislikeAction = feedItemLikeDislikeAction
        self.switcher = feedViewSwitcher
    }

    func viewDidLoad() {
        loadData()
    }

    func loadData() {
        page = 0
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
        if let feedItem = feedItems.last {
            timestamp = feedItem.t
            page = feedItem.p + 1
        }
        view?.refreshFeedView()
    }

    func loadNextPage() {
        if !isLoadingPage {
            isLoadingPage = true
            self.feedLoadPageAction.loadFeedItemsForPageAction(timestamp: timestamp, page: page) { (result) in
                switch result {
                case let .success(feedItems):
                    self.handleFeedItemsPageReceived(feedItems)
                case let .failure(error):
                    self.handleFeedItemsError(error)
                }
                self.isLoadingPage = false
            }
        }
    }

    fileprivate func handleFeedItemsPageReceived(_ feedItems: [FeedItem]) {
        self.feedItems.append(contentsOf: feedItems)
        if let feedItem = feedItems.last {
            timestamp = feedItem.t
            page = feedItem.p + 1
        }
        view?.refreshFeedView()
    }

    fileprivate func handleFeedItemsError(_ error: Error) {
        view?.displayError(title: NSLocalizedString("Error", comment: ""), message: error.localizedDescription)
    }

    func didSelect(section: Int) {
        let feedItem = feedItems[section]
        switcher.presentDetailsView(for: feedItem)
    }

    func configure(cell: FeedTableViewCell, forRow row: Int) {
        let feedItem = feedItems[row] as FeedItem
        cell.bottomView.backgroundColor = Theme.primaryColor

        cell.profileNameLabel.text = feedItem.profile.name
        cell.profileGoalLabel.text = feedItem.profile.general_goal
        if let dateStr = feedItem.date {
            if let date = Utils.parseDate(dateStr: dateStr) {
                cell.itemDateLabel.text = String(format: NSLocalizedString("%@ Meal", comment: ""), Utils.getDateStr(dateFrom: date))
            } else {
                cell.itemDateLabel.text = ""
            }
        } else {
            cell.itemDateLabel.text = ""
        }
        cell.itemEnergyLabel.text = "\(feedItem.energy)kcal"

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

        cell.likeButton.isSelected = feedItem.local_liked
        cell.likeButton.tag = row
        cell.likeButton.addTarget(self, action: #selector(likeDislikeItem(sender:)), for: .touchUpInside)
    }

    @objc func likeDislikeItem(sender: UIButton) {
        let feedItem = self.feedItems[sender.tag] as FeedItem
        self.feedItemLikeDislikeAction.likeDislikeFeedItem(feedItem: feedItem) { (result) in
//            switch result {
//            case let .success(feedItem):
//                print("Success")
//            case let .failure(error):
//                print("Error")
//            }
        }
    }
}
