//
//  VoteResult.swift
//  CatLover
//
//  Created by Jian Ting Li on 1/4/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

struct VoteSuccess: Codable {
    let message: String
    let id: Int
}

struct DeleteSuccess: Codable {
    let message: String
}
