//
//  ImageClient.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/24/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import UIKit

final class ImageHelper {
    
    public static let shared = ImageHelper()
    private var imageCache: NSCache<NSString, UIImage>
    
    private init() {
        imageCache = NSCache<NSString, UIImage>()
        imageCache.countLimit = 100 // number of objects
        imageCache.totalCostLimit = 10 * 1024 * 1024 // max 10MB used
    }
    
    public func getImageFromCache(forKey key: NSString) -> UIImage? {
        return imageCache.object(forKey: key)
    }

    
    static func fetchImage(urlString: String, cat: CatBreedWithNoImage?, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data, response) in
            
            if let error = error {
                completionHandler(error, nil)
                return
            } else if let data = data {
                let image = UIImage.init(data: data)
                DispatchQueue.main.async {
                    if let image = image, let cat = cat {
                        ImageHelper.shared.imageCache.setObject(image, forKey: cat.name as NSString)
                    } else if let image = image {
                        ImageHelper.shared.imageCache.setObject(image, forKey: urlString as NSString)
                    }
                    completionHandler(nil, image)
                }
            }
        }
    }
    
    
    static func getCatImage(catWithNoImage: CatBreedWithNoImage?, catWithImage: CatBreedWithImage?, completionHandler: @escaping (AppError?, CatBreedWithImage?, UIImage?) -> Void) {
        
        //if we have a cat w/ no image url, we need to convert it to the one with image url
        if let catWithNoImage = catWithNoImage {
            CatAPIClient.getCatWithImageFromBreedId(catBreedId: catWithNoImage.id) { (error, catBreedWithImage) in
                if let error = error {
                    completionHandler(error, nil, nil)
                } else if let catBreedWithImage = catBreedWithImage {
                    fetchImage(urlString: catBreedWithImage.url.absoluteString, cat: catWithNoImage) { (error, image) in
                        if let error = error {
                            completionHandler(error, nil, nil)
                        } else if let image = image {
                            completionHandler(nil, catBreedWithImage, image)
                        }
                    }
                }
            }
            
        //if we already have a cat with image url, we use the image url
        } else if let catWithImage = catWithImage {
            fetchImage(urlString: catWithImage.url.absoluteString, cat: nil) { (error, image) in
                if let error = error {
                    completionHandler(error, nil, nil)
                } else if let image = image {
                    completionHandler(nil, catWithImage, image)
                }
            }
        
        //if both inputs are invalid
        } else {
            completionHandler(AppError.invalidInputs, nil, nil)
        }
    }
    
}
