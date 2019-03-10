//
//  FavoriteController.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/4/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController {

    @IBOutlet weak var favoriteCatsCollectionView: UICollectionView!
    var favoriteCats = [FavoriteCat]() {
        didSet {
            DispatchQueue.main.async {
                if self.favoriteCats.isEmpty {
                    self.favoriteCatsCollectionView.backgroundColor = .clear
                } else {
                    self.favoriteCatsCollectionView.backgroundColor = .lightGray
                }
                self.favoriteCatsCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteCatsCollectionView.dataSource = self
        favoriteCatsCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteCats = FavoriteCatModel.fetchAllCats()
    }

}

extension FavoriteController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteCats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = favoriteCatsCollectionView.dequeueReusableCell(withReuseIdentifier: "FavoritePetCell", for: indexPath) as? FavoritePetCell else { return UICollectionViewCell() }
        let currentFavoriteCat = favoriteCats[indexPath.row]
        cell.configureCell(favoriteCat: currentFavoriteCat, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

extension FavoriteController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 325, height: 325)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let detailVC = mainStoryboard.instantiateViewController(withIdentifier: "PetfinderDetailController") as? PetfinderDetailController else { fatalError("WeatherDetailController is nil") }
        let selectedPet = favoriteCats[indexPath.row]
        detailVC.favoriteButton.isEnabled = false
        detailVC.favoritePet = selectedPet
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension FavoriteController: FavoritePetCellDelegate {
    func optionButtonPressed(tag: Int) {
        let selectedCat = favoriteCats[tag]
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (UIAlertAction) in
            FavoriteCatModel.deleteFavoriteCat(at: tag)
            self.favoriteCats = FavoriteCatModel.fetchAllCats()
            self.showAlert(title: "\(selectedCat.catName) is deleted" , message: nil)
        }
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(delete)
        self.present(actionSheet, animated: true, completion: nil)
    }
}
