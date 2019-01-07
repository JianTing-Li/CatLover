//
//  CatImageVoteController.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/31/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit

class CatImageVoteController: UIViewController {
    
    @IBOutlet weak var voteTableView: UITableView!
    
    var allImageVotes = [VoteCatImage]()
    var catsWithImage = [CatBreedWithImage]() {
        didSet {
            DispatchQueue.main.async {
                self.voteTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        voteTableView.dataSource = self
        voteTableView.delegate = self
        
        getAllCatsWithImage()
    }
    
    private func getAllCatsWithImage() {
        //var catsWithImage = [CatBreedWithImage]()
        
        CatAPIClient.getAllVotes(userName: "Jian_Ting88") { (appError, allVotes) in
            if let appError = appError {
                print(appError.errorMessage())
                return
            }
            
            if let allVotes = allVotes {
                self.allImageVotes = allVotes
                //dump(self.allImageVotes)
            }
            
            allVotes?.forEach { voteCatImage in
                CatAPIClient.getCatWithImageFromImageId(catImageId: voteCatImage.imageId) { (appError, catWithImage) in
                    if let appError = appError {
                        print(appError.errorMessage())
                    } else if let catWithImage = catWithImage {
                        self.catsWithImage.append(catWithImage)
                        //print(self.catsWithImage.count)
                    }
                }
            }
            
            //***is there a way I can assign a variable here?
//            self.catsWithImage = catsWithImage
//            dump(self.catsWithImage)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = voteTableView.indexPathForSelectedRow,
            let detailVC = segue.destination as? CatImageVoteDetailController else {
                fatalError("indexPath or destination VC not found")
        }
        
        let catWithImage = catsWithImage[indexPath.row]
        let voteCatImage = allImageVotes[indexPath.row]
        detailVC.catWithImage = catWithImage
        detailVC.voteCatImage = voteCatImage
    }
}

extension CatImageVoteController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catsWithImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = voteTableView.dequeueReusableCell(withIdentifier: "VoteImageCell", for: indexPath) as? VoteImageCell else { fatalError("Cell Not Found") }
        let catWithImage = catsWithImage[indexPath.row]
        cell.configureCell(catWithImage: catWithImage)
        return cell
    }
}

extension CatImageVoteController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}
