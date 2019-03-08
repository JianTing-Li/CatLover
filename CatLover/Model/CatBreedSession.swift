//
//  CatBreedSession.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/8/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

class CatBreedSession {
    private init() {}
    
    private static var catBreed: String = ""
    
    static func getCatBreed() -> String {
        return catBreed
    }
    
    static func setCatBreed(breed: String) {
        self.catBreed = breed
    }
}
