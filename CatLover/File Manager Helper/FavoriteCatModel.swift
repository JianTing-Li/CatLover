//
//  FavoriteCatModel.swift
//  CatLover
//
//  Created by Jian Ting Li on 2/25/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

struct FavoriteCatModel {
    private init() {}
    private static let filename = "FavoriteCatModel.plist"
    private static var favoriteCats = [Cat]()
    
    static func fetchAllCats() -> [Cat] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    let cats = try PropertyListDecoder().decode([Cat].self, from: data)
                    favoriteCats = cats.sorted { $0.breed < $1.breed}
                } catch {
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("Data is nil")
            }
        } else {
            print("\(filename) doesn't exist")
        }
        return favoriteCats
    }
    
    static func saveFavoriteCats() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(favoriteCats)
            try data.write(to: path, options: .atomic)
        } catch {
            print(AppError.propertyListEncodingError(error).errorMessage())
        }
    }
    
    static func favoriteCat(newFavoriteCat: Cat) {
        favoriteCats.append(newFavoriteCat)
        saveFavoriteCats()
    }
    
    static func deleteFavoriteCat(at index: Int) {
        favoriteCats.remove(at: index)
        saveFavoriteCats()
    }
}

