//
//  CatBreed.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/30/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import Foundation

struct CatBreedWithNoImage: Codable {
    let id: String
    let name: String
    let wikipediaUrl: URL?
    let temperament: String
    let description: String
    let origin: String
    let countryCode: String
    let lifeSpan: String
    let weightImperial: String?
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
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressedTail: Int
    let shortLegs: Int
    let hypoallergenic: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case wikipediaUrl = "wikipedia_url"
        case temperament
        case description
        case origin
        case countryCode = "country_code"
        case lifeSpan = "life_span"
        case weightImperial = "weight_imperial"
        case adaptability
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case grooming
        case healthIssues = "health_issues"
        case intelligence
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case vocalisation
        case experimental
        case hairless
        case natural
        case rare
        case rex
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case hypoallergenic
    }
    
}
