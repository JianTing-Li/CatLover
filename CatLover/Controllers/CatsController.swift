//
//  ViewController.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/24/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit

class CatsController: UIViewController {
    
    @IBOutlet weak var catTableView: UITableView!
    @IBOutlet weak var catSearchBar: UISearchBar!
    
    private var refreshControl: UIRefreshControl!
    private var cellBackgroundColor = CatCellBackgroundColor.lightBlue
    
    private var allCatBreedsWithoutImage = [CatBreedWithNoImage]()
    private var allCats = [Cat]() {
        didSet {
            DispatchQueue.main.async {
                self.catTableView.reloadData()
            }
        }
    }
    
    private var apiCall1GetAllCatsFinished = false {
        didSet {
            allCatBreedsWithoutImage.forEach { (catWithoutImage) in
                CatAPIClient.getCatWithImageFromBreedId(catBreedId: catWithoutImage.id, completionHandler: { (appError, catWithImage) in
                    let catImageUrl = catWithImage?.url
                    let cat = Cat.init(breed: catWithoutImage.name,
                                       temperament: catWithoutImage.temperament,
                                       origin: catWithoutImage.origin,
                                       energy: catWithoutImage.energyLevel,
                                       intelligence: catWithoutImage.intelligence,
                                       vocalisation: catWithoutImage.vocalisation,
                                       affection: catWithoutImage.affectionLevel,
                                       description: catWithoutImage.description,
                                       id: catWithoutImage.id,
                                       imageURL: catImageUrl!)
                    CatBreedModel.addNewCat(newCat: cat)
                    if CatBreedModel.fetchAllCats().count == self.allCatBreedsWithoutImage.count {
                        self.allCats = CatBreedModel.fetchAllCats()
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndTitle()
        setupRefreshControl()
        let allCats = CatBreedModel.fetchAllCats()
        if !allCats.isEmpty {
            self.allCats = allCats
        } else {
            getAllCatsWithNoImage()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = catTableView.indexPathForSelectedRow,
            let detailVC = segue.destination as? CatsDetailController else { fatalError("indexPath or destination controller not found") }

        let cat = allCats[indexPath.row]
        detailVC.cat = cat
    }
    
    @IBAction func filterButtonPressed(_ sender: UIBarButtonItem) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let navController = storyBoard.instantiateViewController(withIdentifier: "CatFilterNav") as? UINavigationController else { fatalError("CatFilterNav is nil") }
        //let navControlller = UINavigationController(rootViewController: destinationVC)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true, completion: nil)
    }
    
}


// Initial Setup Functions
extension CatsController {
    private func setDelegatesAndTitle() {
        catTableView.dataSource = self
        catTableView.delegate = self
        catSearchBar.delegate = self
    }
    
    private func getAllCatsWithNoImage() {
        CatAPIClient.getAllCats { (appError, catBreeds) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let catBreeds = catBreeds {
                self.allCatBreedsWithoutImage = catBreeds
                self.apiCall1GetAllCatsFinished = true
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
                self.apiCall1GetAllCatsFinished = true
            }
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
}


extension CatsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = catTableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as? CatCell else { fatalError("CatCell not found") }

        let cat = allCats[indexPath.row]
        cell.backgroundColor = UIColor(hexString: cellBackgroundColor.rawValue)
        cellBackgroundColor.getNextColor()
        cell.configureCell(catBreed: cat)
        return cell
    }
}
extension CatsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}


extension CatsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchText = searchBar.text?.lowercased() else { return }
        
        CatAPIClient.getAllCats() { (appError, allCats) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let allCats = allCats {
                if searchText.trimmingCharacters(in: .whitespaces) == "" {
                    self.allCatBreedsWithoutImage = allCats
                    self.apiCall1GetAllCatsFinished = true
                } else {
                    self.allCatBreedsWithoutImage = allCats.filter { $0.name.lowercased().contains(searchText) }
                    self.apiCall1GetAllCatsFinished = true
                }
            }
            DispatchQueue.main.async {
                searchBar.text = ""
            }
        }
    }
}


