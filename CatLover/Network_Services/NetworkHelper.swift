//
//  NetworkHelper.swift
//  CatLover
//
//  Created by Jian Ting Li on 12/24/18.
//  Copyright © 2018 Jian Ting Li. All rights reserved.
//

import Foundation


final class NetworkHelper {

    static func performDataTask(urlString: String, httpMethod: String, completionHandler: @escaping (AppError?, Data?, HTTPURLResponse?) -> Void) {
        //get url
        guard let url = URL(string: urlString) else {
            completionHandler(AppError.badURL(urlString), nil, nil)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = httpMethod

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                completionHandler(AppError.noResponse, nil, nil)
                return
            }

            print("response status code is \(response.statusCode)")
            if let error = error {
                completionHandler(AppError.networkError(error), nil, response)
            } else if let data = data {
                completionHandler(nil, data, response)
            }
        }.resume()
    }
}
