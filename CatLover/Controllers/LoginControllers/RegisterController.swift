//
//  RegisterController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/11/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showLoginView(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let catTabBarController = storyboard.instantiateViewController(withIdentifier: "CatTabBarController") as! UITabBarController
        catTabBarController.modalTransitionStyle = .crossDissolve
        catTabBarController.modalPresentationStyle = .overFullScreen
        present(catTabBarController, animated: true)
    }
}
