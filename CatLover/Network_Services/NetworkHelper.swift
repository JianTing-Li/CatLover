//
//  NetworkHelper.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/24/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import Foundation

final class NetworkHelper {
    private init() {
        let cache = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 10 * 1024 * 1024, diskPath: nil)
            URLCache.shared = cache
    }
    public static let shared = NetworkHelper()
    
    public func performDataTask(endpointURLString: String,
                                httpMethod: String,
                                httpBody: Data?,
                                completionHandler: @escaping (AppError?, Data?) -> Void) {
        guard let url = URL(string: endpointURLString) else {
            completionHandler(AppError.badURL(endpointURLString), nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            if let data = data {
                completionHandler(nil, data)
            }
        }
        task.resume()
    }
    
    //send jSON to the internet (for requests like POST)
    public func performUploadTask(endpointURLString: String,
                                  httpMethod: String,
                                  httpBody: Data?,
                                  completionHandler: @escaping (AppError?, Data?) -> Void) {
        guard let url = URL(string: endpointURLString) else {
            completionHandler(AppError.badURL(endpointURLString), nil)
            return
        }
        
        var request = URLRequest(url: url)  //initiated URL Request
        //set the type of URL Method (Get, Post, etc)
        request.httpMethod = httpMethod
        //initialized the header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: httpBody) { (data, response, error) in
            if let error = error {
                completionHandler(AppError.networkError(error), nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            if let data = data {
                completionHandler(nil, data)
            }
        }
        task.resume()
    }
}
