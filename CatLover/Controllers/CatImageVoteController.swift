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
    var allVotes = [Vote]() {
        didSet {
            voteTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAllVotes()

        
    }
    
    private func setAllVotes() {
        CatAPIClient.getAllVotes(userName: "Jian_Ting88") { (appError, allVotes) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let allVotes = allVotes {
                self.allVotes = allVotes
            }
        }
    }
}
