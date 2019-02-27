//
//  FavoriteCatModel.swift
//  CatLover
//
//  Created by Jian Ting Li on 2/25/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

struct FavoriteCatModel {
    
}

//struct FavoriteDataPersistenceModel {
//    private static let filename = "FavoriteVenue.plist"
//    private static var favoriteVenues = [FavoriteVenue]()
//
//    static func fetchAllFavoriteVenues() -> [FavoriteVenue] {
//        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename).path
//        if FileManager.default.fileExists(atPath: path) {
//            if let data = FileManager.default.contents(atPath: path) {
//                do {
//                    let venues = try PropertyListDecoder().decode([FavoriteVenue].self, from: data)
//                    favoriteVenues = venues.sorted { $0.date.dateStringToDate > $1.date.dateStringToDate }
//                } catch {
//                    print("Property list decoding error: \(error)")
//                }
//            } else {
//                print("data is nil")
//            }
//        } else {
//            print("\(filename) doesn't exist")
//        }
//        return favoriteVenues
//    }
//
//    static func saveVenues() {
//        let path = DataPersistenceManager.filepathToDocumentsDirectory(filename: filename)
//        do {
//            let data = try PropertyListEncoder().encode(favoriteVenues)
//            try data.write(to: path, options: .atomic)
//        } catch {
//            print("Property list encoding error: \(error)")
//        }
//    }
//
//    static func addVenueToFavorite(newFavoriteVenue: FavoriteVenue) {
//        favoriteVenues.append(newFavoriteVenue)
//        saveVenues()
//    }
//
//    static func deleteFavoriteVenue(at index: Int) {
//        favoriteVenues.remove(at: index)
//        saveVenues()
//    }
//}
