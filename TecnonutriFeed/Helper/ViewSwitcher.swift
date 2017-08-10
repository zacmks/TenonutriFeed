//
// Created by Isaac Mitsuaki Saito on 10/08/2017.
// Copyright (c) 2017 Isaac Mitsuaki Saito. All rights reserved.
//

import Foundation

import UIKit

protocol ViewSwitcher {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension ViewSwitcher {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
