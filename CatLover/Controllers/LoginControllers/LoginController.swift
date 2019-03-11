//
//  LoginController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/4/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let catTabBarController = storyboard.instantiateViewController(withIdentifier: "CatTabBarController") as! UITabBarController
        catTabBarController.modalTransitionStyle = .crossDissolve
        catTabBarController.modalPresentationStyle = .overFullScreen
        present(catTabBarController, animated: true)
    }
}
