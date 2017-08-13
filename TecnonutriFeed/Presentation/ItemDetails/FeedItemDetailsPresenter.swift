//
// Created by Isaac Mitsuaki Saito on 08/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation
import RealmSwift
import YYWebImage

protocol FeedItemDetailsView: class {
    func refreshView()
    func displayError(title: String, message: String, handler: ((UIAlertAction) -> Void)?)
}

protocol FeedItemDetailsPresenter {
    var numberOfFoodItems: Int { get }
//    var switcher: FeedViewSwitcher { get }
    func viewDidLoad()
    func loadData()
    func configure(header: FeedItemDetailsHeaderView)
    func configure(footer: FeedItemDetailsFooterView)
    func configure(cell: FoodTableViewCell, forRow row: Int)
    var headerHeight: CGFloat { get }
    var footerHeight: CGFloat { get }
    var cellHeight: CGFloat { get }
    func likeDislikeItem()
}

class FeedItemDetailsPresenterImpl: FeedItemDetailsPresenter {

    fileprivate weak var view: FeedItemDetailsView!
    fileprivate let feedItemDetailsDisplayAction: FeedItemDetailsDisplayAction
    fileprivate let feedItemLikeDislikeAction: FeedItemLikeDislikeAction
    var feedItem: FeedItem

    var headerHeight: CGFloat {
        return 68.0 + UIScreen.main.bounds.width / 1.25
    }
    var footerHeight: CGFloat {
        return 84.0
    }
    var cellHeight: CGFloat {
        return feedItem.foods.count > 0 ? 104.0 : 0.0
    }
    var numberOfFoodItems: Int {
        return feedItem.foods.count > 0 ? feedItem.foods.count : 0
    }

//    init(view: FeedItemDetailsView, feedDisplayAction: FeedDisplayAction, switcher: FeedViewSwitcher) {
    init(view: FeedItemDetailsView,
         feedItemDetailsDisplayAction: FeedItemDetailsDisplayAction,
         feedItemLikeDislikeAction: FeedItemLikeDislikeAction, feedItem: FeedItem) {
        self.view = view
        self.feedItemDetailsDisplayAction = feedItemDetailsDisplayAction
        self.feedItemLikeDislikeAction = feedItemLikeDislikeAction
        self.feedItem = feedItem
    }

    func viewDidLoad() {
        loadData()
    }

    func loadData() {
        self.feedItemDetailsDisplayAction.displayFeedItemDetails(feedItem: feedItem) { (result) in
            switch result {
            case let .success(feedItem):
                self.handleFeedItemDetailsReceived(feedItem)
            case let .failure(error):
                self.handleFeedItemDetailsError(error)
            }
        }
    }

    fileprivate func handleFeedItemDetailsReceived(_ feedItem: FeedItem) {
        self.feedItem = feedItem
        view?.refreshView()
    }

    fileprivate func handleFeedItemDetailsError(_ error: Error) {
        view?.displayError(title: NSLocalizedString("Error", comment: ""),
                message: error.localizedDescription, handler: { _ in
            self.view?.refreshView()
        })
    }

    func configure(header: FeedItemDetailsHeaderView) {
        header.profileNameLabel.text = self.feedItem.profile?.name ?? ""
        header.profileGoalLabel.text = self.feedItem.profile?.general_goal ?? ""
        header.profileImage.layer.cornerRadius = header.profileImage.bounds.size.width / 2.0;
        if let profileImage = self.feedItem.profile?.image {
            header.profileImage.backgroundColor = UIColor.lightGray
            header.profileImage.yy_setImage(with: URL(string: profileImage), options: YYWebImageOptions.setImageWithFadeAnimation)
        } else {
            header.profileImage.backgroundColor = UIColor.white
            header.profileImage.image = UIImage(named: "profile")
        }
        if let itemImage = self.feedItem.image {
            header.itemImage.yy_setImage(with: URL(string: itemImage), options: YYWebImageOptions.setImageWithFadeAnimation)
        }

        if self.feedItem.local_liked {
            header.likeButton.isSelected = true
        } else {
            header.likeButton.isSelected = false
        }

        header.likeButton.addTarget(self, action: #selector(likeDislikeItem), for: .touchUpInside)
    }

    @objc func likeDislikeItem() {
        self.feedItemLikeDislikeAction.likeDislikeFeedItem(feedItem: self.feedItem) { (result) in
//            switch result {
//            case let .success(feedItem):
//                print("Success")
//            case let .failure(error):
//                print("Error")
//            }
        }
    }

    func configure(footer: FeedItemDetailsFooterView) {
        footer.topView.backgroundColor = Theme.primaryColor
        footer.energyLabel.text = "\(self.feedItem.energy)kcal"
        footer.carbohydrateLabel.text = "\(self.feedItem.carbohydrate)g"
        footer.proteinLabel.text = "\(self.feedItem.protein)g"
        footer.fatLabel.text = "\(self.feedItem.fat)g"
    }

    func configure(cell: FoodTableViewCell, forRow row: Int) {
        let food = feedItem.foods[row] as Food

        cell.descriptionLabel.text = food._description

        cell.amountLabel.text = "\(food.amount)"
        cell.measureLabel.text = food.measure
        cell.weightLabel.text = "(\(food.weight)g)"

        cell.energyLabel.text = "\(food.energy)kcal"
        cell.carbohydrateLabel.text = "\(food.carbohydrate)g"
        cell.proteinLabel.text = "\(food.protein)g"
        cell.fatLabel.text = "\(food.fat)g"
    }
}
