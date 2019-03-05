//
//  PetCell.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/4/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class PetCell: UICollectionViewCell {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petAgeAndBreedLabel: UILabel!
    @IBOutlet weak var petLocationLabel: UILabel!
    
    public func configureCell(pet: Pet) {
        petNameLabel.text = pet.name.petName
        petAgeAndBreedLabel.text = "\(pet.age.age) · \(pet.breeds.breed.breedName)"
        petLocationLabel.text = "\(pet.contact.city.city), \(pet.contact.state.state) \(pet.contact.zip.zipCode)"
        setPetImage(petPhotos: pet.media.photos.photo)
    }
    
    private func setPetImage(petPhotos: [Pet.Media.Photos.Photo]?) {
        guard let petPhotos = petPhotos else { return }
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
