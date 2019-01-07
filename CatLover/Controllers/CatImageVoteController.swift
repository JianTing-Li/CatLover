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
    var allCatsWithImage = [CatBreedWithImage]() {
        didSet {
            DispatchQueue.main.async {
                self.voteTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllCatsWithImage()

    }
    
    private func getAllCatsWithImage() {
        CatAPIClient.getAllVotes(userName: "Jian_Ting88") { (appError, allVotes) in
            if let appError = appError {
                print(appError.errorMessage())
                return
            }
            if let allVotes = allVotes {
                self.allImageVotes = allVotes
                //dump(self.allImageVotes)
            }
            allVotes?.forEach { $0 }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        <#code#>
//    }
}

extension CatImageVoteController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCatsWithImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = voteTableView.dequeueReusableCell(withIdentifier: "VoteImageCell", for: indexPath) as? VoteImageCell else { fatalError("Cell Not Found") }
        let catWithImage = allCatsWithImage[indexPath.row]
        cell.configureCell(catWithImage: catWithImage)
        return cell
    }
}

extension CatImageVoteController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
}
