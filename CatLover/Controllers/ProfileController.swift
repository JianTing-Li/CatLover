//
//  ProfileController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/4/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    private var imagePickerVC: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImagePickerViewController()
    }
    
    private func showImagePickerVC() {
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    private func setupImagePickerViewController() {
        imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self
    }
    
    @IBAction func changeProfilePic(_ sender: UIButton) {
        imagePickerVC.sourceType = .photoLibrary
        showImagePickerVC()
    }

    @IBAction func ChangeProfilePicButtonPressed(_ sender: UIButton) {
        imagePickerVC.sourceType = .photoLibrary
        showImagePickerVC()
    }
    
}

extension ProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            userImageView.layer.cornerRadius = userImageView.bounds.width / 2
            userImageView.clipsToBounds = true
            userImageView.layer.masksToBounds = true
            userImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}


