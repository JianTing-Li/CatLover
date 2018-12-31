//
//  CatImgVote.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/30/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import Foundation

struct CatImageVote {
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
        case countryCode = "country_code"
    }
}


