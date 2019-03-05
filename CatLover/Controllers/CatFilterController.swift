//
//  CatFilterController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/5/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.

import UIKit

//enum buttons: Int {
//    case affectionYes = 0
//    case affectionNo
//    case energeticYes
//    case energeticNo
//    case intelligentYes
//    case intelligentNo
//    case vocalYes
//    case vocalNo
//}

// default
    // text C0C0C0
    // button EBEBEB

// pressed (active)
    // text  white
    // button #4b7bec

class CatFilterController: UIViewController {

    @IBOutlet var buttons: [CatPropertyButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index, button) in buttons.enumerated() {
            button.tag = index
        }
    }
    
    @IBAction func propertyButtonPressed(_ sender: CatPropertyButton) {
        let pressedButton = buttons[sender.tag]
        let associatedButton = buttons[pressedButton.associateButtonTag]
        
        // set user default
        switch pressedButton.tag {
        case 0...1:     // affection
            break
        case 2...3:     // energetic
            break
        case 4...5:     // intelligent
            break
        case 6...7:     // vocal
            break
        default:
            break
        }

        if pressedButton.active {
            pressedButton.switchButtonActivity()
            pressedButton.setButtonOffUI()
        } else {
            pressedButton.switchButtonActivity()
            pressedButton.setButtonOnUI()
            associatedButton.active = false
            associatedButton.setButtonOffUI()
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyFilterPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
