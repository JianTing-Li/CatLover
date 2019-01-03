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
    
    var catWithImage: CatBreedWithImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dump(catWithImage)
        updateCatUI()
    }
    
    //***how to make part of the text Bold?
    private func updateCatUI() {
        guard let catInfo = catWithImage?.breeds[0] else { return }
        
        catName.text = catInfo.name
        ImageHelper.getCatImage(catWithNoImage: nil, catWithImage: catWithImage) { (appError, image) in
            if let appError = appError {
                self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
                print(appError.errorMessage())
            } else if let image = image {
                self.catImage.image = image
            }
        }
        
        temperament.text = "Temperament: \(catInfo.temperament)"
        origin.text = "Origin: \(catInfo.origin)"
        affectionLevel.text = "Affection: \(catInfo.affectionLevel)"
        energyLevel.text = "Energy: \(catInfo.energyLevel)"
        vocalisation.text = "Vocalisation: \(catInfo.vocalisation)"
        intelligence.text = "Intelligence: \(catInfo.intelligence)"
        
        catDescription.text = catInfo.description
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
        //refresh cat and reset catImage
        
    }

}
