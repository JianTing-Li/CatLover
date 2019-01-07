//
//  CatImageVoteDetailController.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/31/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit

class CatImageVoteDetailController: UIViewController {
    
    @IBOutlet weak var catBreedName: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var voteStatus: UILabel!
    
    var voteCatImage: VoteCatImage!
    var catWithImage: CatBreedWithImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCatImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
    }
    
    private func updateUI() {
        catBreedName.text = catWithImage.breeds[0].name
        voteStatus.text = voteCatImage.value == 1 ? "You liked the image! 😸" : "You disliked the image! 😾"
    }
    
    private func setCatImage() {
        ImageHelper.fetchImage(urlString: catWithImage.url.absoluteString, cat: nil) { (appError, catImage) in
            if let appError = appError {
                DispatchQueue.main.async {
                    self.catImage.image = UIImage.init(named: "catImgPlaceholder2")
                }
                print(appError.errorMessage())
            } else if let catImage = catImage {
                DispatchQueue.main.async {
                    self.catImage.image = catImage
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
    
    @IBAction func changeVoteImage(_ sender: UIButton) {
        guard let catWithImage = self.catWithImage else { return }
        
        let voteValue = sender.tag == 0 ? 0 : 1
        let vote = VoteBody.init(imageId: catWithImage.id, subId: "Jian_Ting88", value: voteValue)
        
        do {
            let data = try JSONEncoder().encode(vote)
            
            CatAPIClient.voteCatImage(bodyData: data) { (appError, voteSuccess) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if let voteResult = voteSuccess {
                    if voteResult.message == "SUCCESS" {
                        let messageTitle = voteValue == 1 ? "You Liked the Cat Image 😸" : "You Disliked the Cat Image 😾"
                        DispatchQueue.main.async {
                            self.voteStatus.text = messageTitle
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
    
    
    @IBAction func deleteVote(_ sender: UIButton) {
        CatAPIClient.deleteCatImageVote(voteId: voteCatImage.id.description) { (appError, deleteSuccess) in
            if let appError = appError {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error Message", message: appError.errorMessage())
                }
            } else if let deleteSuccess = deleteSuccess {
                if deleteSuccess.message == "SUCCESS" {
                    DispatchQueue.main.async {
                        self.voteStatus.text = "Image Vote Deleted 🤔"
                        self.showAlert(title: "Vote Successfully Deleted", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Fail to Delete Vote", message: "")
                    }
                }
            } 
        }
    }
    

}
