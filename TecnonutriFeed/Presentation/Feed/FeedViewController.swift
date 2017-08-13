//
//  FeedViewController.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 09/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import UIKit
import MoPub
import Firebase

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MPAdViewDelegate, FeedView {

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
        // TODO fetchConfig() and loadAds() to better packages?
        fetchConfig()
    }

// TODO fetchConfig() and loadAds() to better packages?
    func fetchConfig() {
#if DEBUG
        RemoteConfig.remoteConfig().configSettings = RemoteConfigSettings(developerModeEnabled: true)!
#endif
        RemoteConfig.remoteConfig().setDefaults(Config.defaultValues)
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0) { (status, error) in
            guard error == nil else {
                print("Error fetching remote config: \(error)")
                self.loadAds()
                return
            }

            let remoteConfig = RemoteConfig.remoteConfig()
            remoteConfig.activateFetched()
            let showAds = remoteConfig["show_ads"].boolValue ?? true
            if (showAds) {
                self.loadAds()
            }
        }
    }

// TODO fetchConfig() and loadAds() to better packages?
    func loadAds() {
        let adSize: CGSize = UI_USER_INTERFACE_IDIOM() == .pad ? MOPUB_LEADERBOARD_SIZE : MOPUB_BANNER_SIZE
        let bannerAdView = MPAdView.init(adUnitId: "bd5ab3e9fa8c43b88e663b6e17e4c1e5", size: adSize)
        bannerAdView?.delegate = self
        var adFrame: CGRect = CGRect.zero
        adFrame.size.width = adSize.width
        adFrame.size.height = adSize.height
        adFrame.origin.x = (UIScreen.main.bounds.width - adSize.width) / 2.0
        adFrame.origin.y = UIScreen.main.bounds.height / 2.0
        adFrame.origin.y = view.bounds.height - adSize.height
        bannerAdView!.frame = adFrame
        self.view?.addSubview(bannerAdView!)
        bannerAdView?.loadAd()
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

    func viewControllerForPresentingModalView() -> UIViewController! {
        return self
    }
}
