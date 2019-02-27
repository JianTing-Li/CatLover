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
    case jsonDecodingError(Error)
    case jsonEncodingError(Error)
    case propertyListDecodingError(Error)
    case propertyListEncodingError(Error)
    case invalidInputs
    case badStatusCode(String)
    case fileNameNotExist(String)
    
    public func errorMessage() -> String {
        switch self {
        case .badURL(let str):
            return "badURL: \(str)"
        case .networkError(let error):
            return "networkError: \(error)"
        case .jsonDecodingError(let error):
            return "json decoding error: \(error)"
        case .jsonEncodingError(let error):
            return "json encoding error: \(error)"
        case .propertyListDecodingError(let error):
            return "Property List Decoding Error: \(error)"
        case .propertyListEncodingError(let error):
            return "Property List Encoding Error: \(error)"
        case .invalidInputs:
            return "invalid input for imageHelper getCatImage method"
        case .badStatusCode(let message):
            return "bad status code: \(message)"
        case .fileNameNotExist(let fileName):
            return "\(fileName) doesn't exist"
        }
    }
    
}
