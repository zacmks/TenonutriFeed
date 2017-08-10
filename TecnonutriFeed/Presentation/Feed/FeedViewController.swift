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
        let feedDisplayActionImpl = FeedDisplayActionImpl(feedItemManager: feedItemManager)
        let feedViewSwitcher = FeedViewSwitcherImpl(feedViewController: self)

        presenter = FeedPresenterImpl(view: self, feedDisplayAction: feedDisplayActionImpl, switcher: feedViewSwitcher)
//        iOS related
        tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self

        presenter.viewDidLoad()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfFeedItems
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.section)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 6.0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48.0 + 40 + UIScreen.main.bounds.width / 1.25
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(row: indexPath.row)
    }

    func refreshFeedView() {
        tableView.reloadData()
    }

//    TODO per page
    func loadFeedViewPage(page: Int) {

    }

    func displayFeedLoadError(title: String, message: String) {
        presentAlert(withTitle: title, message: message)
    }
}
