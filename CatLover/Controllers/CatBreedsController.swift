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
    private var refreshControl: UIRefreshControl!
    
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
        
        getAllCats()
        setupRefreshControl()
    }
    
    private func getAllCats() {
        CatAPIClient.getAllCats { (appError, catBreeds) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let catBreeds = catBreeds {
                self.allCatBreeds = catBreeds
                //dump(self.allCatBreeds)
            }
        }
    }

    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        catTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(fetchCats), for: .valueChanged)
    }

    @objc private func fetchCats() {
        refreshControl.beginRefreshing()
        
        CatAPIClient.getAllCats() { (appError, allCats) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let allCats = allCats {
                self.allCatBreeds = allCats
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
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
        cell.configureCell(catBreed: catBreed)
        return cell
    }
}

extension CatBreedsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension CatBreedsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text?.lowercased() else { return }
        
        CatAPIClient.getAllCats() { (appError, allCats) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let allCats = allCats {
                if searchText.trimmingCharacters(in: .whitespaces) == "" {
                    self.allCatBreeds = allCats
                } else {
                    self.allCatBreeds = allCats.filter { $0.name.lowercased().contains(searchText) }
                }
            }
            DispatchQueue.main.async {
                searchBar.text = ""
            }
        }
    }
}
