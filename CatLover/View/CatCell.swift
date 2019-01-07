//
//  CatCell.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/30/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit

class CatCell: UITableViewCell {
    @IBOutlet weak var catImg: UIImageView!
    @IBOutlet weak var catBreedName: UILabel!
    @IBOutlet weak var catOrigin: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var urlString = ""
    
    public func configureCell(catBreed: CatBreedWithNoImage) {
        catBreedName.text = catBreed.name
        catOrigin.text = catBreed.origin
        
        if let image = ImageHelper.shared.getImageFromCache(forKey: catBreed.name as NSString) {
            catImg.image = image
        } else {
            activityIndicator.startAnimating()
            ImageHelper.getCatImage(catWithNoImage: catBreed, catWithImage: nil) { (appError, catWithImage, catImage) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.catImg.image = UIImage.init(named: "catImgPlaceholder")
                    }
                    print(appError.errorMessage())
                } else if let catImage = catImage {
                    self.catImg.image = catImage
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
}


//self.labels?.forEach {
//    $0.layer.borderWidth = 2.0
//    $0.layer.cornerRadius = 5.0
//    $0.layer.masksToBounds = true
//}
