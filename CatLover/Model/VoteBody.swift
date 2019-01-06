//
//  Vote.swift
//  CatLover
//
//  Created by Jian Ting Li on 1/4/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation


struct VoteBody: Codable {
    let imageId: String
    let subId: String
    let value: Int
    
    private enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case subId = "sub_id"
        case value
    }
}



