//
//  FeedItemManagerDBTest.swift
//  TecnonutriFeed
//
//  Created by Isaac Mitsuaki Saito on 13/08/2017.
//  Copyright © 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import XCTest
import RealmSwift
@testable import Tecnutri_Feed

class FeedItemManagerDBTest: XCTestCase {

    let feedItemManagerDB = FeedItemManagerDB()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testLikeDislikeFeedItem() {
        let feedItem = FeedItem()
        feedItem.id = 1

        let realm = try! Realm()
        try! realm.write {
            realm.add(feedItem, update: true)
        }

        XCTAssertEqual(feedItem.local_liked, false)
        feedItemManagerDB.likeDislikeFeedItem(feedItem: feedItem) { result in
            switch result {
            case let .success(feedItem):
                XCTAssertEqual(feedItem.local_liked, true)
            case let .failure(error):
                print("Error")
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
