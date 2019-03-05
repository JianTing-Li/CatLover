//
//  CatCell.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/30/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.

import UIKit
import Kingfisher

class CatCell: UITableViewCell {
    @IBOutlet weak var catImg: UIImageView!
    @IBOutlet weak var catBreedName: UILabel!
    @IBOutlet weak var catOrigin: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var imageURLString = ""
    
    public func configureCell(catBreed: Cat) {
        catBreedName.text = catBreed.breed
        catOrigin.text = catBreed.origin
        
        //catImg.kf.setImage(with: catBreed.url)
        
        imageURLString = catBreed.imageURL.absoluteString
        catImg.image = nil
        if let image = ImageHelper.shared.getImageFromCache(forKey: imageURLString as NSString) {
            catImg.image = image
        } else {
            activityIndicator.startAnimating()
            ImageHelper.fetchImage(urlString: imageURLString) { [weak self] (appError, image) in
                if let appError = appError {
                    print(appError.errorMessage())
                    // use custom delegate to show alert
                } else if let image = image {
                    if self?.imageURLString == catBreed.imageURL.absoluteString {
                        self?.catImg.image = image
                    }
                }
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
}
