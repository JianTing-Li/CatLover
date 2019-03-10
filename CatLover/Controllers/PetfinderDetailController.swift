//
//  PetfinderDetailController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/4/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class PetfinderDetailController: UIViewController {
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petAgeAndGenderLabel: UILabel!
    @IBOutlet weak var breedAndLocationLabel: UILabel!
    @IBOutlet weak var petContactEmailTextView: UITextView!
    @IBOutlet weak var petContactNumberTextView: UITextView!
    @IBOutlet weak var petDescriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var pet: Pet?
    var favoritePet: FavoriteCat?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        if let pet = pet {
            setPetImage(petPhotos: pet.media.photos.photo)
            title = pet.name.petName
            petAgeAndGenderLabel.text = "\(pet.age.age) · \(pet.sex.sex)"
            breedAndLocationLabel.text = "\(pet.breeds.breed.breedName) · \(pet.contact.city.city), \(pet.contact.state.state) \(pet.contact.zip.zipCode)"
            petContactEmailTextView.text = pet.contact.email.email
            petContactNumberTextView.text = pet.contact.phone.phoneNum
            petDescriptionTextView.text = pet.description.description
        } else if let favoritePet = favoritePet {
            title = favoritePet.catName
            if let imageData = favoritePet.imageData { petImageView.image = UIImage(data: imageData) }
            petAgeAndGenderLabel.text = "\(favoritePet.catAge) · \(favoritePet.catGender)"
            breedAndLocationLabel.text = "\(favoritePet.catBreed) · \(favoritePet.catCity), \(favoritePet.catState) \(favoritePet.catZipCode)"
            petContactEmailTextView.text = favoritePet.catContactEmail
            petContactNumberTextView.text = favoritePet.catContactNum
            petDescriptionTextView.text = favoritePet.catDescription
        }
    }
    
    private func setPetImage(petPhotos: [Pet.Media.Photos.Photo]) {
        var imageURLString = ""
        for photo in petPhotos {
            if photo.photoSize == "x" {
                imageURLString = photo.photoURLString
                break
            }
        }
        if let image = ImageHelper.shared.getImageFromCache(forKey: imageURLString as NSString) {
            petImageView.image = image
        } else {
            activityIndicator.startAnimating()
            ImageHelper.fetchImage(urlString: imageURLString) { [weak self] (appError, image) in
                DispatchQueue.main.async {
                    if let appError = appError {
                        print(appError.errorMessage())
                    } else if let image = image {
                        self?.petImageView.image = image
                    }
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    
    @IBAction func favoritePetButtonPressed(_ sender: UIBarButtonItem) {
        let imageData = petImageView.image?.jpegData(compressionQuality: 0.5)
        let alert = UIAlertController(title: "Save Cat🐱 to Favorite?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let favoriteCat = FavoriteCat.init(imageData: imageData,
                                               catAge: self.pet!.age.age,
                                               catGender: self.pet!.sex.sex,
                                               catContactEmail: self.pet!.contact.email.email,
                                               catContactNum: self.pet!.contact.phone.phoneNum,
                                               catDescription: self.pet!.description.description,
                                               catCity: self.pet!.contact.city.city,
                                               catState: self.pet!.contact.state.state,
                                               catZipCode: self.pet!.contact.zip.zipCode,
                                               catName: self.pet!.name.petName,
                                               catBreed: self.pet!.breeds.breed.breedName)
            FavoriteCatModel.favoriteCat(newFavoriteCat: favoriteCat)
            self.showAlert(title: "\(self.pet!.name.petName) is Favorited", message: nil)
        }))
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
}
