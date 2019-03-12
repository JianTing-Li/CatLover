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
    case lightBlue = "#74b9ff"
    case lightViolet = "#a29bfe"
    case lightGreen = "#81ecec"  // light green
    case lightGrey = "#dfe6e9"
    
    public mutating func getNextColor() {
        switch self {
        case .lightBlue:
            self = .lightViolet
        case .lightViolet:
            self = .lightGreen
        case .lightGreen:
            self = .lightGrey
        case .lightGrey:
            self = .lightBlue
        }
    }
}
