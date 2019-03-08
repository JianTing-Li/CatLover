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
    // catlover@kittycat.kitten
    // (cat) cat-cats
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var pet: Pet!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        setPetImage(petPhotos: pet.media.photos.photo)
        title = pet.name.petName
        petAgeAndGenderLabel.text = "\(pet.age.age) · \(pet.sex.sex)"
        breedAndLocationLabel.text = "\(pet.breeds.breed.breedName) · \(pet.contact.city.city), \(pet.contact.state.state) \(pet.contact.zip.zipCode)"
        petContactEmailTextView.text = pet.contact.email.email
        petContactNumberTextView.text = pet.contact.phone.phoneNum
        petDescriptionTextView.text = pet.description.description
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
}
