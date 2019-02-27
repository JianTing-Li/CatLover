//
//  CatBreedModel.swift
//  CatLover
//
//  Created by Jian Ting Li on 2/26/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

struct CatBreedModel {
    private init() {}
    private static let filename = "CatBreedModel.plist"
    private static var allCats = [Cat]()
    
    static func fetchAllCats() -> [Cat] {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    let cats = try PropertyListDecoder().decode([Cat].self, from: data)
                    allCats = cats.sorted { $0.breed < $1.breed}
                } catch {
                    print("Property list decoding error: \(error)")
                }
            } else {
                print("Data is nil")
            }
        } else {
            print("\(filename) doesn't exist")
        }
        return allCats
    }
    
    static func saveCats() {
        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
        do {
            let data = try PropertyListEncoder().encode(allCats)
            try data.write(to: path, options: .atomic)
        } catch {
            print(AppError.propertyListEncodingError(error).errorMessage())
        }
    }
    
    static func addNewCat(newCat: Cat) {
        allCats.append(newCat)
        saveCats()
    }
}
