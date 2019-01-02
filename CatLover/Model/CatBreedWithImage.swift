//
//  Cat.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/30/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import Foundation

struct CatBreedWithImage: Codable {
    
    struct CatInfo: Codable {
        let id: String
        let name: String
        let description: String
        let lifeSpan: String
        let temperament: String
        let wikipediaUrl: URL
        let origin: String
        let countryCode: String
        let adaptability: Int
        let affectionLevel: Int
        let childFriendly: Int
        let dogFriendly: Int
        let energyLevel: Int
        let grooming: Int
        let healthIssues: Int
        let intelligence: Int
        let sheddingLevel: Int
        let socialNeeds: Int
        let strangerFriendly: Int
        let vocalisation: Int
        
        private enum KittyBreedCodingKeys: String, CodingKey {
            case id
            case name
            case description
            case lifeSpan = "life_span"
            case temperament
            case wikipediaUrl = "wikipedia_url"
            case origin
            case countryCode = "country_code"
            case adaptability
            case affectionLevel = "affection_level"
            case childFriendly = "child_friendly"
            case dogFriendly = "dog_friendly"
            case energyLevel = "energy_level"
            case groomimg
            case healthIssues = "health_issues"
            case intelligence
            case sheddingLevel = "shedding_level"
            case socialNeeds = "social_needs"
            case strangerFriendly = "stranger_friendly"
            case vocalisation
        }
    }
    let breeds: [CatInfo]
    let id: String  //image id
    let url: URL    //image
}
