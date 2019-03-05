//
//  PetfinderController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/3/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class PetfinderController: UIViewController {
    
    @IBOutlet weak var petfinderCollectionView: UICollectionView!
    var pets = [Pet]() {
        didSet {
            DispatchQueue.main.async {
                dump(self.pets)
                self.petfinderCollectionView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        petfinderCollectionView.delegate = self
        petfinderCollectionView.dataSource = self
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

extension PetfinderController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = petfinderCollectionView.dequeueReusableCell(withReuseIdentifier: "PetCell", for: indexPath) as? PetCell else { return UICollectionViewCell() }
        let pet = pets[indexPath.row]
        cell.configureCell(pet: pet)
        return cell
    }
}

extension PetfinderController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 325, height: 325)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "PetfinderDetailController") as? PetfinderDetailController else { fatalError("WeatherDetailController is nil") }
        let selectedPet = pets[indexPath.row]
        detailVC.pet = selectedPet
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
