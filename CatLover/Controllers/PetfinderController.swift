//
//  PetfinderController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/3/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class PetfinderController: UIViewController {
    
    var pets = [Pet]() {
        didSet {
            DispatchQueue.main.async {
                dump(self.pets)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fectPetsForAdoption(location: "10023", breed: nil)
    }
    
    private func fectPetsForAdoption(location: String, breed: String?) {
        PetfinderAPIClient.getPets(location: location, breed: breed) { (appError, pets) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let pets = pets {
                self.pets = pets
            }
        }
    }

}
