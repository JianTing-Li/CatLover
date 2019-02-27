//
//  catCellBackgroundColor.swift
//  CatLover
//
//  Created by Jian Ting Li on 1/7/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

//TO DO: Study the extension
enum CatCellBackgroundColor: String {
    case lightBlue = "#A8D8EA"
    case lightViolet = "#AA96DA"
    case lightPink = "#FCBAD3"
    case lightYellow = "#FFFFD2"
    
    public mutating func getNextColor() {
        switch self {
        case .lightBlue:
            self = .lightViolet
        case .lightViolet:
            self = .lightPink
        case .lightPink:
            self = .lightYellow
        case .lightYellow:
            self = .lightBlue
        }
    }
}
