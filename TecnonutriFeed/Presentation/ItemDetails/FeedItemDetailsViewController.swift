//
//  FeedItemDetailsViewController.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 10/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

class FeedItemDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FeedItemDetailsView {

    @IBOutlet weak var tableView: UITableView!


    var presenter: FeedItemDetailsPresenter!
    var feedItem: FeedItem!

    func setup(feedItem: FeedItem) {
        self.feedItem = feedItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let feedItemManager = FeedItemManagerImpl(feedItemManagerAPI: FeedItemManagerAPI(), feedItemManagerDB: FeedItemManagerDB())
        let feedItemDetailsDisplayAction = FeedItemDetailsDisplayActionImpl(feedItemManager: feedItemManager)
        let feedItemLikeDislikeAction = FeedItemLikeDislikeActionImpl(feedItemManager: feedItemManager)
        presenter = FeedItemDetailsPresenterImpl(view: self,
                feedItemDetailsDisplayAction: feedItemDetailsDisplayAction,
                feedItemLikeDislikeAction: feedItemLikeDislikeAction,
                feedItem: feedItem)
//        TableView
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodTableViewCell")
        tableView.register(UINib(nibName: "FeedItemDetailsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FeedItemDetailsHeaderView")
        tableView.register(UINib(nibName: "FeedItemDetailsFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "FeedItemDetailsFooterView")
        tableView.delegate = self
        tableView.dataSource = self
//        Refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        self.tableView.refreshControl = refreshControl


        if let dateStr = feedItem.date {
            if let date = Utils.parseDate(dateStr: dateStr) {
                self.title = String(format: NSLocalizedString("%@ Meal", comment: ""), Utils.getDateStr(dateFrom: date))
            } else {
                self.title = "Tecnonutri"
            }
        } else {
            self.title = "Tecnonutri"
        }

        presenter.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFoodItems
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FeedItemDetailsHeaderView") as! FeedItemDetailsHeaderView
        presenter.configure(header: headerView)
        return headerView
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FeedItemDetailsFooterView") as! FeedItemDetailsFooterView
        presenter.configure(footer: footerView)
        return footerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return presenter.headerHeight
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return presenter.footerHeight
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.cellHeight
    }

    func loadData() {
        presenter.loadData()
    }

    func refreshView() {
        tableView.reloadData()
        self.tableView.refreshControl!.endRefreshing()
    }

    func displayError(title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        presentAlert(withTitle: title, message: message, button: NSLocalizedString("Dismiss", comment: ""), handler: handler)
    }

}
