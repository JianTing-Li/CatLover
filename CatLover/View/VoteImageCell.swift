//
//  VoteCell.swift
//  CatLover
//
//  Created by Jian Ting Li on 1/6/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class VoteImageCell: UITableViewCell {
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catBreed: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var imageUrlString = ""
    
    public func configureCell(catWithImage: CatBreedWithImage) {
        catBreed.text = catWithImage.breeds[0].name
        
        imageUrlString = catWithImage.url.absoluteString
        if let image = ImageHelper.shared.getImageFromCache(forKey: catWithImage.url.absoluteString as NSString) {
            catImage.image = image
        } else {
            activityIndicator.startAnimating()
            ImageHelper.getCatImage(catWithNoImage: nil, catWithImage: catWithImage) { (appError, catWithImage, catImage) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.catImage.image = UIImage.init(named: "catImgPlaceholder")
                    }
                    print(appError.errorMessage())
                } else if let catImage = catImage {
                    DispatchQueue.main.async {
                        self.catImage.image = catImage
                    }
                }
                self.activityIndicator.stopAnimating()
            }
        }
        
    }
}
