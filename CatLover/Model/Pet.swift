//
//  Pet.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/3/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation

enum UnknownValueDecodingError: Error {
    case noValueFound
    case emptyDictionary
}

extension Decodable {
    // Allows you to decode a value that is either in an array or a dictionary
    static func decodeUnknown<T>(value: T) throws -> [T] {
        if let dictionaryValue = value as? [String : T] {
            if dictionaryValue.keys.count > 0 {
                let indexValue = dictionaryValue.keys.first!
                return [dictionaryValue[indexValue]!] // An array of 1 breed
            } else {
                throw UnknownValueDecodingError.emptyDictionary
            }
        } else if let arrayValue = value as? [T] {
            return arrayValue
        }
        throw UnknownValueDecodingError.noValueFound
    }
}


struct PetfinderData: Codable {
    let petfinder: Petfinder
}

struct Petfinder: Codable {
    let pets: Pets
}

struct Pets: Codable {
    let pet: [Pet]
}

struct Pet: Codable {
    struct Contact: Codable {
        struct Phone: Codable {
            let phoneNum: String
            private enum CodingKeys: String, CodingKey {
                case phoneNum = "$t"
            }
        }
        let phone: Phone
        struct State: Codable {
            let state: String
            private enum CodingKeys: String, CodingKey {
                case state = "$t"
            }
        }
        let state: State
        struct Email: Codable {
            let email: String
            private enum CodingKeys: String, CodingKey {
                case email = "$t"
            }
        }
        let email: Email
        struct City: Codable {
            let city: String
            private enum CodingKeys: String, CodingKey {
                case city = "$t"
            }
        }
        let city: City
        struct Zip: Codable {
            let zipCode: String
            private enum CodingKeys: String, CodingKey {
                case zipCode = "$t"
            }
        }
        let zip: Zip
    }
    let contact: Contact
    
    struct Age: Codable {
        let age: String
        private enum CodingKeys: String, CodingKey {
            case age = "$t"
        }
    }
    let age: Age
    
    struct Size: Codable {
        let size: String
        private enum CodingKeys: String, CodingKey {
            case size = "$t"
        }
    }
    let size: Size
    
    struct Media: Codable {
        struct Photos: Codable {
            struct Photo: Codable {
                let photoSize: String
                let photoURLString: String
                let photoNum: String
                private enum CodingKeys: String, CodingKey {
                    case photoSize = "@size"
                    case photoURLString = "$t"
                    case photoNum = "@id"
                }
            }
            let photo: [Photo]
        }
        let photos: Photos
    }
    let media: Media
    
    struct PetId: Codable {
        let petId: String
        private enum CodingKeys: String, CodingKey {
            case petId = "$t"
        }
    }
    let id: PetId
    
    struct Breeds: Codable {
        struct Breed: Codable {
//            let breedName: [String]
            let breedName: String
            private enum CodingKeys: String, CodingKey {
                case breedName = "$t"
            }
            
//            init(from decoder: Decoder) throws {
//                let container = try decoder.container(keyedBy: CodingKeys.self)
//
//                let breedName = try container.decode(String.self, forKey: .breedName)
//                let decodedValue = try Breed.decodeUnknown(value: breedName)
//
//
////                guard case let decodedValue as? String = try self.decodeUnknown(value: breedName) else {
////                    throw DecodingError.keyNotFound(CodingKeys.breedName, DecodingError.Context.init(codingPath: [CodingKeys.breedName], debugDescription: "Could not decode breedName"))
////                }
//
//                self.breedName = decodedValue
//            }
        }
        let breed: Breed
    }
    let breeds: Breeds
    
    struct Name: Codable {
        let petName: String
        private enum CodingKeys: String, CodingKey {
            case petName = "$t"
        }
    }
    let name: Name
    
    struct Sex: Codable {
        let sex: String
        private enum CodingKeys: String, CodingKey {
            case sex = "$t"
        }
    }
    let sex: Sex
    
    struct Description: Codable {
        let description: String
        private enum CodingKeys: String, CodingKey {
            case description = "$t"
        }
    }
    let description: Description
    
    struct ShelterId: Codable {
        let shelterId: String
        private enum CodingKeys: String, CodingKey {
            case shelterId = "$t"
        }
    }
    let shelterId: ShelterId
    
    struct LastUpdate: Codable {
        let lastUpdate: String
        private enum CodingKeys: String, CodingKey {
            case lastUpdate = "$t"
        }
    }
    let lastUpdate: LastUpdate
    
    struct Animal: Codable {
        let animalName: String
        private enum CodingKeys: String, CodingKey {
            case animalName = "$t"
        }
    }
    let animal: Animal
}
