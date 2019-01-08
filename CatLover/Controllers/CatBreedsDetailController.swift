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
    
    var catWithoutImage: CatBreedWithNoImage!
    var catWithImage: CatBreedWithImage!
    
    private var gotCatWithImage = false {
        didSet {
            if let image = ImageHelper.shared.getImageFromCache(forKey: catWithImage.url.absoluteString as NSString) {
                DispatchQueue.main.async {
                    self.catImage.image = image
                }
            } else {
                activityIndicator.startAnimating()
                ImageHelper.getCatImage(catWithNoImage: self.catWithoutImage, catWithImage: nil) { (appError, catWithImage, image) in
                    if let appError = appError {
                        self.setPlaceHolderImage()
                        print(appError.errorMessage())
                    } else if let image = image {
                        DispatchQueue.main.async {
                            self.catImage.image = image
                        }
                    }
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gotCatWithImage = true
        updateCatUI()
    }
    
    private func updateCatUI() {
        let catInfo =  catWithImage.breeds[0]
        catName.text = catInfo.name
        
        temperament.text = "\(catInfo.temperament)"
        origin.text = "Origin: \(catInfo.origin)"
        affectionLevel.text = "Affection: \(catInfo.affectionLevel)"
        energyLevel.text = "Energy: \(catInfo.energyLevel)"
        vocalisation.text = "Vocalisation: \(catInfo.vocalisation)"
        intelligence.text = "Intelligence: \(catInfo.intelligence)"
        
        catDescription.text = catInfo.description
    }
    
    private func setNewCatImage() {
        CatAPIClient.getCatWithImageFromBreedId(catBreedId: catWithoutImage.id) { (appError, catWithImage) in
            if let appError = appError {
                self.setPlaceHolderImage()
                print(appError.errorMessage())
            } else if let catWithImage = catWithImage {
                self.catWithImage = catWithImage
                self.gotCatWithImage = true
            }
        }
    }
    
    private func setPlaceHolderImage() {
        DispatchQueue.main.async {
            self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
        }
    }
    
    private func showAlert(title: String, message: String) {
        //create An Alert control & enter the alert title & message
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //add an action to the alert so the user can interact w/ it such an ok button
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in }
        
        //offically add the action to the alert
        alertController.addAction(okAction)
        
        //present the alert w/ action
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func voteImage(_ sender: UIButton) {
        guard let catWithImage = self.catWithImage else { return }
        
        let voteValue = sender.tag == 0 ? 0 : 1
        let vote = VoteBody.init(imageId: catWithImage.id, subId: "Jian_Ting88", value: voteValue)
        
        do {
            let data = try JSONEncoder().encode(vote)
            
            CatAPIClient.voteCatImage(bodyData: data) { (appError, voteResult) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if let voteResult = voteResult {
                    if voteResult.message == "SUCCESS" {
                        let messageTitle = voteValue == 1 ? "You Liked the Cat Image" : "You Disliked the Cat Image"
                        DispatchQueue.main.async {
                            self.showAlert(title: messageTitle, message: "")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(title: "Fail to Vote Cat Image", message: "")
                        }
                    }
                } 
            }
        } catch {
            print(AppError.encodingError(error))
        }
    }
    
    @IBAction func getNewCatPic(_ sender: UIButton) {
        setNewCatImage()
    }

}
