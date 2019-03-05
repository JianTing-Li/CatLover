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

    
    static func fetchImage(urlString: String, completionHandler: @escaping (AppError?, UIImage?) -> Void) {
        
        NetworkHelper.shared.performDataTask(endpointURLString: urlString, httpMethod: "GET", httpBody: nil) { (error, data) in
            
            if let error = error {
                completionHandler(error, nil)
                return
            } else if let data = data {
                let image = UIImage.init(data: data)
                DispatchQueue.main.async {
                    if let image = image {
                        ImageHelper.shared.imageCache.setObject(image, forKey: urlString as NSString)
                    }
                    completionHandler(nil, image)
                }
            }
        }
    }
}
