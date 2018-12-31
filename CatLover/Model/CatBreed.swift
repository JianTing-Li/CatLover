//
//  CatBreed.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/30/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import Foundation

struct CatBreed {
    let id: String
    let name: String
    let wikipedia_url: String
    let temperament: String
    let description: String
    let origin: String
    let country_code: String
    let life_span: String
    let weight_imperial: String
    let adaptability: Int
    let affection_level: Int
    let child_friendly: Int
    let dog_friendly: Int
    let energy_level: Int
    let grooming: Int
    let health_issues: Int
    let intelligence: Int
    let shedding_level: Int
    let social_needs: Int
    let stranger_friendly: Int
    let vocalisation: Int
    let experimental: Int
    let hairless: Int
    let natural: Int
    let rare: Int
    let rex: Int
    let suppressed_tail: Int
    let short_legs: Int
    let hypoallergenic: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case wikipediaUrl = "wikipedia_url"
        case temperament
        case description
        case origin
        case countryCode
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
        case suppressed_tail = "suppressed_tail"
        case shortLegs = "short_legs"
        case hypoallergenic
    }
}
