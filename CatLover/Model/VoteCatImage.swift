//
//  VoteCatImage.swift
//  CatLover
//
//  Created by Jian Ting Li on 1/5/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation


struct VoteCatImage: Codable {
    let id: Int
    let imageId: String
    let subId: String
    let createdAt: String
    let value: Int
    let countryCode: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case imageId = "image_id"
        case subId = "sub_id"
        case createdAt = "created_at"
        case value
        case countryCode
    }
}


