//
//  zipCodeHelper.swift
//  CatLover
//
//  Created by Jian Ting Li on 3/7/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import Foundation
import CoreLocation

class ZipCodeHelper {
    private init() {}
    static func getLocationName(from zipCode: String, completionHandler: @escaping (Error?, String?) -> Void) {
        let geocoder = CLGeocoder()     // object helps one get the location (CL = CoreLocation)
        DispatchQueue.global(qos: .userInitiated).async {
            geocoder.geocodeAddressString(zipCode){(placemarks, error) -> Void in
                DispatchQueue.main.async {
                    if let placemark = placemarks?.first, let name = placemark.locality {
                        completionHandler(nil, name)
                    } else {
                        completionHandler(error, nil)
                    }
                }
            }
        }
    }
    
}
