//
//  AppConstants.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

final class AppConstants {
    
    static let shared = AppConstants()
    
    private init() {}

    let mainStoryBoardIdentifier = "Main"
    let editVCIdentifier = "EditConfiguration"
    var selectedUnitSystem: CSUnits = .international
    var selectedEndpoint: CSWeatherSource = .forecastIO
    var selectedCity: CSCity = CSCity(location: CSLocation(latitude: 4.609, longitude: -74.081), name: "Bogota")
    
    var cities: [CSCity] {
        var citieshub: [CSCity] = []
        citieshub.append(CSCity(location: CSLocation(latitude: 4.609, longitude: -74.081), name: "Bogota"))
        citieshub.append(CSCity(location: CSLocation(latitude: 50.000, longitude: -85.000), name: "Ontario"))
        citieshub.append(CSCity(location: CSLocation(latitude: 40.730610, longitude: -73.935), name: "New York"))
        citieshub.append(CSCity(location: CSLocation(latitude: 48.864, longitude: 2.349), name: "Paris"))
        
        return citieshub
    }
}
