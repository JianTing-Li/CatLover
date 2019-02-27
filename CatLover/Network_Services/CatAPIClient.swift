//
//  CatAPIClient.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/30/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import Foundation

final class CatAPIClient {
    public static func getAllCats(completionHandler: @escaping (AppError?, [CatBreedWithNoImage]?) -> Void) {
        
        let urlEnpointString = "https://api.thecatapi.com/v1/breeds"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlEnpointString, httpMethod: "GET", httpBody: nil) { (appError, data) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    let catBreeds = try JSONDecoder().decode([CatBreedWithNoImage].self, from: data)
                    completionHandler(nil, catBreeds)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
    }
    
    
    public static func getCatWithImageFromBreedId(catBreedId: String, completionHandler: @escaping (AppError?, CatBreedWithImage?) -> Void) {
        let urlEnpointString = "https://api.thecatapi.com/v1/images/search?breed_ids=\(catBreedId)&api_key=\(SecretKey.key)"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlEnpointString, httpMethod: "GET", httpBody: nil) { (appError, data) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    let catBreedOuter = try JSONDecoder().decode([CatBreedWithImage].self, from: data)
                    //guard against empty array
                    guard !catBreedOuter.isEmpty else {
                        return
                    }
                    completionHandler(nil, catBreedOuter[0])
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        }
    }
    
    public static func getCatWithImageFromImageId(catImageId: String, completionHandler: @escaping (AppError?, CatBreedWithImage?) -> Void) {
        let urlEnpointString = "https://api.thecatapi.com/v1/images/\(catImageId)"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlEnpointString, httpMethod: "GET", httpBody: nil) { (appError, data) in
            if let appError = appError {
                completionHandler(appError, nil)
            } else if let data = data {
                do {
                    let catWithImage = try JSONDecoder().decode(CatBreedWithImage.self, from: data)
                    completionHandler(nil, catWithImage)
                } catch {
                    completionHandler(AppError.jsonDecodingError(error), nil)
                }
            }
        } 
    }
}

