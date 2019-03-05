//
//  CatFilterController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/5/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class CatFilterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyFilterPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
