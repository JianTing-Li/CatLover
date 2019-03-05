//
//  CatPropertyButton.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/5/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

// default
// text C0C0C0
// button EBEBEB

// pressed (active)
// text  white
// button #4b7bec

class CatPropertyButton: UIButton {
    @IBInspectable var active: Bool = false
    @IBInspectable var associateButtonTag: Int = 0
    
    func switchButtonActivity() {
        if active {
            active = false
        } else {
            active = true
        }
    }
    
    func setButtonOnUI() {
        self.backgroundColor = UIColor(hexString: "#4b7bec")
        self.setTitleColor(.white, for: .normal)
    }
    
    func setButtonOffUI() {
        self.backgroundColor = UIColor(hexString: "EBEBEB")
        self.setTitleColor(UIColor(hexString: "C0C0C0"), for: .normal)
    }
}


