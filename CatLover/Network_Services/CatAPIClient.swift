//
//  CatAPIClient.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/30/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import Foundation

final class CatAPIClient {
    static func getAllCats(completionHandler: @escaping (AppError?, [CatBreed]?) -> Void) {
        let urlString = "https://api.thecatapi.com/v1/breeds"
        
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data, response) in
            if let error = error {
                completionHandler(error, nil)
            } else if let data = data {
                do {
                    let catBreeds = try JSONDecoder().decode([CatBreed].self, from: data)
                    completionHandler(nil, catBreeds)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
    static func getVotedImages() {

    }
}
