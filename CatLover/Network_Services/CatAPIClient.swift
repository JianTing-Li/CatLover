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
        
        let urlString = "https://api.thecatapi.com/v1/breeds"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data, response) in
            if let appError = appError {
                completionHandler(appError, nil)
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
    
    
    public static func getCatWithImageFromBreedId(catBreedId: String, completionHandler: @escaping (AppError?, CatBreedWithImage?) -> Void) {
        //print(catBreedId)
        let urlString = "https://api.thecatapi.com/v1/images/search?breed_ids=\(catBreedId)&api_key=\(SecretKey.key)"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            
            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
                let statusCode = httpResponse?.statusCode ?? -999
                completionHandler(AppError.badStatusCode(statusCode.description), nil)
                return
            }
            
            if let data = data {
                do {
                    let catBreedOuter = try JSONDecoder().decode([CatBreedWithImage].self, from: data)
                    //guard against empty array
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
    
    public static func getCatWithImageFromImageId(catImageId: String, completionHandler: @escaping (AppError?, CatBreedWithImage?) -> Void) {
        let urlString = "https://api.thecatapi.com/v1/images/\(catImageId)"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            
            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
                let statusCode = httpResponse?.statusCode ?? -999
                completionHandler(AppError.badStatusCode(statusCode.description), nil)
                return
            }
            
            if let data = data {
                do {
                    let catWithImage = try JSONDecoder().decode(CatBreedWithImage.self, from: data)
                    completionHandler(nil, catWithImage)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        } 
    }
    
   
    public static func voteCatImage(bodyData: Data, completionHandler: @escaping (AppError?, VoteResult?) -> Void) {

        let urlString = "https://api.thecatapi.com/v1/votes?api_key=\(SecretKey.key)"

        NetworkHelper.shared.performUploadTask(endpointURLString: urlString, httpMethod: "POST", httpBody: bodyData) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }

            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
                let statusCode = httpResponse?.statusCode ?? -999
                completionHandler(AppError.badStatusCode(statusCode.description), nil)
                return
            }

            if let data = data {
                do {
                    let voteResult = try JSONDecoder().decode(VoteResult.self, from: data)
                    completionHandler(nil, voteResult)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }

        }
    }
    
    
    //username is Jian_Ting88
    public static func getAllVotes(userName: String, completionHandler: @escaping (AppError?, [VoteCatImage]?) -> Void) {
        let urlString = "https://api.thecatapi.com/v1/votes?api_key=\(SecretKey.key)&sub_id=\(userName)"
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            
            guard let response = httpResponse, (200...299).contains(response.statusCode) else {
                let statusCode = httpResponse?.statusCode ?? -999
                completionHandler(AppError.badStatusCode(statusCode.description), nil)
                return
            }
            
            if let data = data {
                do {
                    let allVotes = try JSONDecoder().decode([VoteCatImage].self, from: data)
                    completionHandler(nil, allVotes)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
}
