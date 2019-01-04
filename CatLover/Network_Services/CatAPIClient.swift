//
//  CatAPIClient.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/30/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import Foundation

final class CatAPIClient {
    
    static func getAllCats(completionHandler: @escaping (AppError?, [CatBreedWithNoImage]?) -> Void) {
        
        let urlString = "https://api.thecatapi.com/v1/breeds"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let catBreeds = try JSONDecoder().decode([CatBreedWithNoImage].self, from: data)
                    completionHandler(nil, catBreeds)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
    
    static func getCatWithImage(catBreedId: String, completionHandler: @escaping (AppError?, CatBreedWithImage?) -> Void) {
        //print(catBreedId)
        let urlString = "https://api.thecatapi.com/v1/images/search?breed_ids=\(catBreedId)&api_key=\(SecretKey.key)"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let catBreedOuter = try JSONDecoder().decode([CatBreedWithImage].self, from: data)
                    //mala gives an empty array
                    guard !catBreedOuter.isEmpty else {
                        completionHandler(AppError.noData, nil)
                        return
                    }
                    completionHandler(nil, catBreedOuter[0])
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
    
    static func voteCatImage() {
        
    }
//    static func getVotedImages() {
//
//    }
}
