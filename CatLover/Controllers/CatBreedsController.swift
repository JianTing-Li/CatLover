//
//  ViewController.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/24/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit
//fix cache to urls string
//not getting all data

class CatBreedsController: UIViewController {
    
    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var catSearchBar: UISearchBar!
    private var refreshControl: UIRefreshControl!
    
    var allCatBreedsWithoutImage = [CatBreedWithNoImage]()
    var allCatBreedsWithImage = [CatBreedWithImage]() {
        didSet {
            DispatchQueue.main.async {
                self.catTableView.reloadData()
            }
        }
    }
    
    private var apiCall1GetAllCatsFinished = false {
        didSet {
            guard apiCall1GetAllCatsFinished else { return }
            var catsWithImage = [CatBreedWithImage]()
            let lastIndexOfCatWithoutImage = allCatBreedsWithoutImage.count - 1
            
            //TO DO: still not getting all cats (need to be fixed)
            allCatBreedsWithoutImage.enumerated().forEach { (index, catWithoutImage) in
                CatAPIClient.getCatWithImageFromBreedId(catBreedId: catWithoutImage.id) { (appError, catWithImage) in
                    if let appError = appError {
                        print(appError.errorMessage())
                    } else if let catWithImage = catWithImage {
                        catsWithImage.append(catWithImage)
                        
                        if index == lastIndexOfCatWithoutImage {
                            self.allCatBreedsWithImage = catsWithImage
                            //dump(self.allCatBreedsWithImage)
                            print("WithImage1: \(self.allCatBreedsWithImage.count)")
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        catTableView.dataSource = self
        catTableView.delegate = self
        catSearchBar.delegate = self
        
        getAllCatsWithNoImage()
        setupRefreshControl()
    }
    
    private func getAllCatsWithNoImage() {
        CatAPIClient.getAllCats { (appError, catBreeds) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let catBreeds = catBreeds {
                self.allCatBreedsWithoutImage = catBreeds
                self.apiCall1GetAllCatsFinished = true
                //dump(self.allCatBreeds)
                print("noImage: \(self.allCatBreedsWithoutImage.count)")
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
                self.allCatBreedsWithoutImage = allCats
            }
            
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = catTableView.indexPathForSelectedRow,
            let detailVC = segue.destination as? CatBreedsDetailController else { fatalError("indexPath or destination controller not found") }
        
        let catWithoutImage = allCatBreedsWithoutImage[indexPath.row]
        let catWithImage = allCatBreedsWithImage[indexPath.row]
        detailVC.catWithoutImage = catWithoutImage
        detailVC.catWithImage = catWithImage
    }
    
}


extension CatBreedsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCatBreedsWithImage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = catTableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as? CatCell else { fatalError("cell not found") }
        
        let catBreed = allCatBreedsWithImage[indexPath.row]
        //how come the cell doesn't return right away in this async call?
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
                    self.allCatBreedsWithoutImage = allCats
                } else {
                    self.allCatBreedsWithoutImage = allCats.filter { $0.name.lowercased().contains(searchText) }
                }
            }
            DispatchQueue.main.async {
                searchBar.text = ""
            }
        }
    }
}
