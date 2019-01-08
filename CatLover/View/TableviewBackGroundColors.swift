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


//https://www.iosapptemplates.com/blog/swift-programming/convert-hex-colors-to-uicolor-swift-4
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
