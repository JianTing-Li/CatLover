//
//  FavoritePetCell.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/8/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

protocol FavoritePetCellDelegate: AnyObject {
    func optionButtonPressed(tag: Int)
}

class FavoritePetCell: UICollectionViewCell {
    
    weak var delegate: FavoritePetCellDelegate?
    
    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petAgeAndBreedLabel: UILabel!
    @IBOutlet weak var petLocationLabel: UILabel!
    @IBOutlet weak var optionButton: UIButton!
    
    public func configureCell(favoriteCat: FavoriteCat, indexPath: IndexPath) {
        optionButton.tag = indexPath.row
        petImageView.layer.cornerRadius = 50
        petImageView.layer.borderWidth = 1
        petImageView.layer.borderColor = UIColor(hexString: "#ffffff").cgColor
        petImageView.clipsToBounds = true
        petImageView.layer.masksToBounds = true
        if let imageData = favoriteCat.imageData { petImageView.image = UIImage(data: imageData) }
        petNameLabel.text = favoriteCat.catName
        petAgeAndBreedLabel.text = "\(favoriteCat.catAge) · \(favoriteCat.catBreed)"
        petLocationLabel.text = "\(favoriteCat.catCity), \(favoriteCat.catState) \(favoriteCat.catZipCode)"
    }
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {
        delegate?.optionButtonPressed(tag: sender.tag)
    }
}
