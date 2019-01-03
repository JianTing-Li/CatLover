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
    
    var allCatBreeds = [CatBreed]() {
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
        
        CatAPIClient.getAllCats { (appError, catBreeds) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let catBreeds = catBreeds {
                self.allCatBreeds = catBreeds
                dump(self.allCatBreeds)
            }
        }
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
    
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
        cell.catImg.image = UIImage.init(named: "catImgPlaceholder")
        
        return cell
    }
}

extension CatBreedsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension CatBreedsController: UISearchBarDelegate {
    
}
