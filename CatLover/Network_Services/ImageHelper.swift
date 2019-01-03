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
    
    static func getCatImage(cat: CatBreedWithImage) -> UIImage? {
        var catImage: UIImage? = nil
        let imageURL = cat.url
        
        fetchImage(urlString: imageURL.absoluteString) { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                catImage = image
            }
        }
        return catImage
    }
    
}
