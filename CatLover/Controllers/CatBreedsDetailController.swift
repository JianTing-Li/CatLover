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
    var catWithImage: CatBreedWithImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCatUI()
        setCatWithImage()
    }
    
    private func setCatWithImage() {
        ImageHelper.getCatImage(catWithNoImage: catWithoutImage, catWithImage: nil) { (appError, image) in
            if let appError = appError {
                self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
                print(appError.errorMessage())
            } else if let image = image {
                self.catImage.image = image
            }
        }
        
        CatAPIClient.getCatWithImage(catBreedId: catWithoutImage.id) { (appError, catWithImage) in
            if let appError = appError {
                self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
                print(appError.errorMessage())
            } else if let catWithImage = catWithImage {
                self.catWithImage = catWithImage
            }
        }
    }
    
    //***how to make part of the text Bold?
    private func updateCatUI() {
        catName.text = catWithoutImage.name
        
        temperament.text = "Temperament: \(catWithoutImage.temperament)"
        origin.text = "Origin: \(catWithoutImage.origin)"
        affectionLevel.text = "Affection: \(catWithoutImage.affectionLevel)"
        energyLevel.text = "Energy: \(catWithoutImage.energyLevel)"
        vocalisation.text = "Vocalisation: \(catWithoutImage.vocalisation)"
        intelligence.text = "Intelligence: \(catWithoutImage.intelligence)"
        
        catDescription.text = catWithoutImage.description
    }
    
    private func getNewImage() {
        CatAPIClient.getCatWithImage(catBreedId: catWithoutImage.id) { (appError, catWithImage) in
            if let appError = appError {
                self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
                print(appError.errorMessage())
            } else if let catWithImage = catWithImage {
                self.catWithImage = catWithImage
            }
        }
        
        ImageHelper.getCatImage(catWithNoImage: nil, catWithImage: catWithImage) { (appError, image) in
            if let appError = appError {
                self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
                print(appError.errorMessage())
            } else if let image = image {
                self.catImage.image = image
            }
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
                        let messageTitle = voteResult.id == 1 ? "You Liked the Cat Image" : "You Disliked the Cat Image"
                        DispatchQueue.main.async {
                            self.showAlert(title: messageTitle, message: "")
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(title: "Fail to Vote Cat Image", message: "")
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Fail to Vote Cat Image", message: "")
                    }
                }
            }
        } catch {
            print("Encoding Error: \(error)")
        }
    }
    
    @IBAction func getNewCatPic(_ sender: UIButton) {
        getNewImage()
    }

}
