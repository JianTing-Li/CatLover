//
//  ViewController.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/24/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit

class CatBreedsController: UIViewController {
    
    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var catSearchBar: UISearchBar!
    
    var allCatBreeds = [CatBreedWithNoImage]() {
        didSet {
            DispatchQueue.main.async {
                self.catTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catTableView.dataSource = self
        catTableView.delegate = self
        catSearchBar.delegate = self
        
        CatAPIClient.getAllCats { (appError, catBreeds) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let catBreeds = catBreeds {
                self.allCatBreeds = catBreeds
                //dump(self.allCatBreeds)
            }
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = catTableView.indexPathForSelectedRow,
            let detailController = segue.destination as? CatBreedsDetailController else { fatalError("indexPath or destination controller not found") }
        
        let catWithoutImage = allCatBreeds[indexPath.row]
        detailController.catWithoutImage = catWithoutImage
    }
    
}


extension CatBreedsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCatBreeds.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = catTableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as? CatCell else { fatalError("cell not found") }
        
        let catBreed = allCatBreeds[indexPath.row]
   
        cell.catBreedName.text = catBreed.name
        cell.catOrigin.text = catBreed.origin
        
        if let image = ImageHelper.shared.getImageFromCache(forKey: catBreed.name as NSString) {
            cell.catImg.image = image
        } else {
            ImageHelper.getCatImage(catWithNoImage: catBreed, catWithImage: nil) { (appError, catImage) in
                if let appError = appError {
                    cell.catImg.image = UIImage.init(named: "catImgPlaceholder")
                    print(appError.errorMessage())
                } else if let catImage = catImage {
                    cell.catImg.image = catImage
                }
            }
        }
        return cell
    }
}

extension CatBreedsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension CatBreedsController: UISearchBarDelegate {
    
}
