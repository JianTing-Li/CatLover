//
//  DataPersistenceManager.swift
//  CatLover
//
//  Created by Jian Ting Li on 2/25/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

final class DataPersistenceManager {
    private init() {}
    
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
