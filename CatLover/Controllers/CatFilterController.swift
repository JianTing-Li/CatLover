//
//  CatFilterController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/5/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.

import UIKit

enum CatProperty: String {
    case affection
    case energy
    case intelligent
    case vocal
}

class CatFilterController: UIViewController {

    @IBOutlet var buttons: [CatPropertyButton]!
    var catFilters = [String: Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index, button) in buttons.enumerated() {
            button.tag = index
        }
    }
    
    @IBAction func propertyButtonPressed(_ sender: CatPropertyButton) {
        let pressedButton = buttons[sender.tag]
        switch pressedButton.tag {
        case 0...1:
            setFilterSetting(pressedButton: pressedButton, catProperty: CatProperty.affection)
        case 2...3:
            setFilterSetting(pressedButton: pressedButton, catProperty: CatProperty.energy)
        case 4...5:
            setFilterSetting(pressedButton: pressedButton, catProperty: CatProperty.intelligent)
        case 6...7:
            setFilterSetting(pressedButton: pressedButton, catProperty: CatProperty.vocal)
        default:
            break
        }
        print(catFilters)
    }
    
    private func setFilterSetting(pressedButton: CatPropertyButton, catProperty: CatProperty) {
        let associatedButton = buttons[pressedButton.associateButtonTag]
        if pressedButton.active {
            catFilters[catProperty.rawValue] = nil
            pressedButton.switchButtonActivity()
            pressedButton.setButtonOffUI()
        } else {
            if pressedButton.tag % 2 == 0 {
                catFilters[catProperty.rawValue] = true
            } else {
                catFilters[catProperty.rawValue] = false
            }
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
        UserDefaults.standard.set(catFilters, forKey: UserDefaultsKeys.catFilters)
        dismiss(animated: true, completion: nil)
    }
}
