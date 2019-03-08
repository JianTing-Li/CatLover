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
    var zipCode = ""
    
    public var catBreed: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petfinderCollectionView.delegate = self
        petfinderCollectionView.dataSource = self
        fetchPetsForAdoption(location: "10023", breed: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchPetsForAdoption(location: "10023", breed: "\(CatBreedSession.getCatBreed())")
//        print("current breed is \(CatBreedSession.getCatBreed())")
    }
    
    private func fetchPetsForAdoption(location: String, breed: String?) {
        PetfinderAPIClient.getPets(location: location, breed: breed) { (appError, pets) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let pets = pets {
                self.pets = pets
            }
        }
    }
    
    @IBAction func locationButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Enter a Zipcode", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Zipcode Here"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert!.textFields![0]
            self.zipCode = textField.text ?? "no comment"
            ZipCodeHelper.getLocationName(from: self.zipCode) { (error, locationName) in
                if let error = error {
                    print("Invalid Zipcode Entered: \(self.zipCode)")
                    self.showAlert(title: "Invalid ZipCode", message: "\(error)")
                } else if let _ = locationName {
                    self.fetchPetsForAdoption(location: self.zipCode, breed: nil)
                }
            }
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
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
