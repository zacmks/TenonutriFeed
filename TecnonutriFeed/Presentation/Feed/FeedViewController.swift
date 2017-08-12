//
//  FeedViewController.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 09/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FeedView {

    @IBOutlet weak var tableView: UITableView!
    var presenter: FeedPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        //        let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
        let feedItemManager = FeedItemManagerImpl(feedItemManagerAPI: FeedItemManagerAPI(), feedItemManagerDB: FeedItemManagerDB())
        let feedDisplayAction = FeedDisplayActionImpl(feedItemManager: feedItemManager)
        let feedLoadPageAction = FeedLoadPageActionImpl(feedItemManager: feedItemManager)
        let feedItemLikeDislikeAction = FeedItemLikeDislikeActionImpl(feedItemManager: feedItemManager)
        let feedViewSwitcher = FeedViewSwitcherImpl(feedViewController: self)

        presenter = FeedPresenterImpl(view: self,
                feedDisplayAction: feedDisplayAction,
                feedLoadPageAction: feedLoadPageAction,
                feedItemLikeDislikeAction: feedItemLikeDislikeAction,
                feedViewSwitcher: feedViewSwitcher)
//        iOS related
        self.tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.tableView.bounds.size.width, height: 0.01));
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
//        Refresh control
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        self.tableView.refreshControl = refreshControl

        presenter.viewDidLoad()
    }

    func loadData() {
        presenter.loadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.switcher.prepare(for: segue, sender: sender)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFeedItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= presenter.numberOfFeedItems - 1 {
            presenter.loadNextPage()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68.0 + 52 + UIScreen.main.bounds.width / 1.25 + 4.0 + 4.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(section: indexPath.row)
    }

    func refreshFeedView() {
        tableView.reloadData()
        tableView.refreshControl!.endRefreshing()
    }

    func displayError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
}
