//
//  PetfinderAPIClient.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/5/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

final class PetfinderAPIClient {
    private init() {}
    
    static func getPets(location: String, breed: String?, completion: @escaping (AppError?, [Pet]?) -> Void) {
        let endpointUrlString = "http://api.petfinder.com/pet.find?key=\(SecretKeys.petFinderKey)&location=\(location)&breed=\(breed ?? "")&animal=cat&count=5&format=json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        NetworkHelper.shared.performDataTask(endpointURLString: endpointUrlString, httpMethod: "Get", httpBody: nil) { (appError, data) in
            if let appError = appError {
                completion(appError, nil)
            } else if let data = data {
                do {
                    let pets = try JSONDecoder().decode(PetfinderData.self, from: data).petfinder.pets.pet
                    completion(nil, pets)
                } catch {
                    completion(AppError.jsonDecodingError(error) ,nil)
                }
            }
        }
    }
}
