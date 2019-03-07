//
//  Breed.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/7/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

struct PetfinderOuter: Codable {
    let petfinder: Breeds
}

struct Breeds: Codable {
    let breeds: Breed
}

struct Breed: Codable {
    let breed: [CatBreed]
}

struct CatBreed: Codable {
    let breed: String
    private enum CodingKeys: String, CodingKey {
        case breed = "$t"
    }
}
