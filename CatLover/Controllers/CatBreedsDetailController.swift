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

    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var temperament: UILabel!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var affectionLevel: UILabel!
    @IBOutlet weak var energyLevel: UILabel!
    @IBOutlet weak var vocalisation: UILabel!
    @IBOutlet weak var intelligence: UILabel!
    
    @IBOutlet weak var catDescription: UITextView!
    
    //this variable is not needed once I segue the catWithImage directly
    var catWithoutImage: CatBreedWithNoImage!
    
    var catWithImage: CatBreedWithImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCatUI()
        setNewCatImage()
    }
    
    private func updateCatUI() {
        catName.text = catWithoutImage.name
        
        temperament.text = "\(catWithoutImage.temperament)"
        origin.text = "Origin: \(catWithoutImage.origin)"
        affectionLevel.text = "Affection: \(catWithoutImage.affectionLevel)"
        energyLevel.text = "Energy: \(catWithoutImage.energyLevel)"
        vocalisation.text = "Vocalisation: \(catWithoutImage.vocalisation)"
        intelligence.text = "Intelligence: \(catWithoutImage.intelligence)"
        
        catDescription.text = catWithoutImage.description
    }
    
    private func setNewCatImage() {
        //get the cat breed with an image (the image is random)
        CatAPIClient.getCatWithImageFromBreedId(catBreedId: catWithoutImage.id) { (appError, catWithImage) in
            if let appError = appError {
                self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
                print(appError.errorMessage())
            } else if let catWithImage = catWithImage {
                //set the cat breed (w/ a random image) to a variable
                self.catWithImage = catWithImage
                
                //convert the url to a uiimage and set to imageview
                ImageHelper.getCatImage(catWithNoImage: self.catWithoutImage, catWithImage: nil) { (appError, catWithImage, image) in
                    if let appError = appError {
                        self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
                        print(appError.errorMessage())
                    } else if let image = image {
                        self.catImage.image = image
                    }
                }
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
                        let messageTitle = voteValue == 1 ? "You Liked the Cat Image" : "You Disliked the Cat Image"
                        DispatchQueue.main.async {
                            self.showAlert(title: messageTitle, message: "")
                        }
                    } else { //3***is this necessary?
                        DispatchQueue.main.async {
                            self.showAlert(title: "Fail to Vote Cat Image", message: "")
                        }
                    }
                } 
            }
        } catch {
            print("Encoding Error: \(error)")
        }
    }
    
    @IBAction func getNewCatPic(_ sender: UIButton) {
        setNewCatImage()
    }

}
