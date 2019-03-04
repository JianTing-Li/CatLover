//
//  CatBreedsDetailController.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/24/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit

//add activity indicator & cache
//remodel UI so Description is so not cramped
//nsattributed string
    //2***how to make part of the text Bold?

class CatBreedsDetailController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var temperament: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var affectionLevel: UILabel!
    @IBOutlet weak var energyLevel: UILabel!
    @IBOutlet weak var vocalisation: UILabel!
    @IBOutlet weak var intelligence: UILabel!
    @IBOutlet weak var catDescription: UITextView!
    
    var cat: Cat!
    var catWithImage: CatBreedWithImage? {
        didSet {
            setCatImage(imageURLString: (catWithImage!.url.absoluteString))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        updateCatUI()
        setCatImage(imageURLString: cat.imageURL.absoluteString)
    }
    
    private func updateCatUI() {
        catName.text = cat.breed
        temperament.text = "\(cat.temperament)"
        origin.text = "Origin: \(cat.origin)"
        affectionLevel.text = "Affection: \(cat.affection)"
        energyLevel.text = "Energy: \(cat.energy)"
        vocalisation.text = "Vocalisation: \(cat.vocalisation)"
        intelligence.text = "Intelligence: \(cat.intelligence)"
        catDescription.text = cat.description
    }
    
    private func setCatImage(imageURLString: String) {
        if let image = ImageHelper.shared.getImageFromCache(forKey: imageURLString as NSString) {
            DispatchQueue.main.async {
                self.catImage.image = image
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
            ImageHelper.fetchImage(urlString: imageURLString) { [weak self] (appError, image) in
                DispatchQueue.main.async {
                    if let appError = appError {
                        print(appError.errorMessage())
                    } else if let image = image {
                        self?.catImage.image = image
                    }
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private func setNewCatImage() {
        CatAPIClient.getCatWithImageFromBreedId(catBreedId: cat.id) { [weak self] (appError, catWithImage) in
            if let appError = appError {
                self?.setPlaceHolderImage()
                print(appError.errorMessage())
            } else if let catWithImage = catWithImage {
                self?.catWithImage = catWithImage
            }
        }
    }
    
    private func setPlaceHolderImage() {
        DispatchQueue.main.async {
            self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
        }
    }
    
    @IBAction func getNewCatPic(_ sender: UIButton) {
        setNewCatImage()
    }

}
