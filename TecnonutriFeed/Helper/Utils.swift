//
// Created by Isaac Mitsuaki Saito on 12/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation

class Utils {

    static func parseDate(dateStr: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateStr)
        return date
    }

    static func getDateStr(dateFrom: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: dateFrom)
    }
}