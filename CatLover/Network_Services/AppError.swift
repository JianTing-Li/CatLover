//
//  AppError.swift
//  CatLover
//
//  Created by Jian Ting Li on 1/1/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

//Need Clarafication
enum AppError: Error {
    case badURL(String)
    case networkError(Error)
    case noResponse
    case decodingError(Error)
    case invalidInputs
    case noData
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let str):
            return "badURL: \(str)"
        case .networkError(let error):
            return "networkError: \(error)"
        case .noResponse:
            return "no network response"
        case .decodingError(let error):
            return "decodingError: \(error)"
        case .invalidInputs:
            return "invalid input for imageHelper getCatImage method"
        case .noData:
            return "network request works but returns no data"
        }
    }
    
}
