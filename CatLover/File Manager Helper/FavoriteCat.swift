//
//  FavoritePet.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/8/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

struct FavoriteCat: Codable {
    let imageData: Data?
    let catAge: String
    let catGender: String
    let catContactEmail: String
    let catContactNum: String
    let catDescription: String
    let catCity: String
    let catState: String
    let catZipCode: String
    let catName: String
//    let catBreed: [String]
    let catBreed: String
}
