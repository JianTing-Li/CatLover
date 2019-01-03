//
//  ImageClient.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/24/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit

final class ImageHelper {
    
    static func fetchImage(urlString: String, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
        
        NetworkHelper.performDataTask(urlString: urlString, httpMethod: "GET") { (error, data, response) in
            
            if let error = error {
                completionHandler(error, nil)
                
            } else if let data = data {
                let image = UIImage.init(data: data)
                DispatchQueue.main.async {
                    completionHandler(nil, image)
                }
            }
        }
    }
    
    
    static func getCatImage(catWithNoImage: CatBreedWithNoImage?, catWithImage: CatBreedWithImage?, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
        
        //if we have a cat w/ no image url, we need to convert it to the one with image url
        if let catWithNoImage = catWithNoImage {
            CatAPIClient.getCatWithImage(catBreedId: catWithNoImage.id) { (error, catBreedWithImage) in
                if let error = error {
                    completionHandler(error, nil)
                } else if let catBreedWithImage = catBreedWithImage {
                    fetchImage(urlString: catBreedWithImage.url.absoluteString) { (error, image) in
                        if let error = error {
                            completionHandler(error, nil)
                        } else if let image = image {
                            completionHandler(nil, image)
                        }
                    }
                }
            }
            
        //if we already have a cat with image url, we use the image url
        } else if let catWithImage = catWithImage {
            fetchImage(urlString: catWithImage.url.absoluteString) { (error, image) in
                if let error = error {
                    completionHandler(error, nil)
                } else if let image = image {
                    completionHandler(nil, image)
                }
            }
        
        //if both inputs are invalid
        } else {
            completionHandler(AppError.invalidInputs, nil)
        }
    }
    
}
