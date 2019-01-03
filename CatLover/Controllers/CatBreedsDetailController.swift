//
//  CatBreedsDetailController.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/24/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit

class CatBreedsDetailController: UIViewController {

    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var temperament: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var affectionLevel: UILabel!
    @IBOutlet weak var energyLevel: UILabel!
    @IBOutlet weak var vocalisation: UILabel!
    @IBOutlet weak var intelligence: UILabel!
    
    @IBOutlet weak var catDescription: UITextView!
    
    var catWithoutImage: CatBreedWithNoImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCatUI()
    }
    
    private func setCatWithImage() {
        
    }
    
    //***how to make part of the text Bold?
    private func updateCatUI() {
        catName.text = catWithoutImage.name
        getNewImage()
        
        temperament.text = "Temperament: \(catWithoutImage.temperament)"
        origin.text = "Origin: \(catWithoutImage.origin)"
        affectionLevel.text = "Affection: \(catWithoutImage.affectionLevel)"
        energyLevel.text = "Energy: \(catWithoutImage.energyLevel)"
        vocalisation.text = "Vocalisation: \(catWithoutImage.vocalisation)"
        intelligence.text = "Intelligence: \(catWithoutImage.intelligence)"
        
        catDescription.text = catWithoutImage.description
    }
    
    private func getNewImage() {
        ImageHelper.getCatImage(catWithNoImage: catWithoutImage, catWithImage: nil) { (appError, image) in
            if let appError = appError {
                self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
                print(appError.errorMessage())
            } else if let image = image {
                self.catImage.image = image
            }
        }
    }

    @IBAction func voteImage(_ sender: UIButton) {
        switch sender.tag {
        case 0: //dislike
            //activate get request for dislike
            break
        case 1: //like
            //activate get request for like
            break
        default:
            return
        }
    }
    
    @IBAction func getNewCatPic(_ sender: UIButton) {
        getNewImage()
    }

}
