//
//  VoteCell.swift
//  CatLover
//
//  Created by Jian Ting Li on 1/6/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit

//***why only class can inherit UITableViewCell?
class VoteImageCell: UITableViewCell {
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catBreed: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var imageUrlString = ""
    
    public func configureCell(catWithImage: CatBreedWithImage) {
        
    }
}
