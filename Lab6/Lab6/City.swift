//
//  City.swift
//  Lab6
//
//  Created by Kathy Nguyen on 10/22/18.
//  Copyright © 2018 Kathy Nguyen. All rights reserved.
//

import Foundation
import MapKit

class Cities {
    
    var cities:[City] = []
    
    func numOfCities() -> Int {
        return cities.count
    }
    func addCity(city: City) {
        cities.append(city)
    }
    
    func getCity(index: Int) -> City {
        return cities[index]
    }
    
}

class City {
    var cityName:String?
    var latitude:CLLocationDegrees?
    var longitude:CLLocationDegrees?
    
    init(cn: String, lat: CLLocationDegrees, long: CLLocationDegrees) {
        cityName = cn
        latitude = lat
        longitude = long
    }
}
