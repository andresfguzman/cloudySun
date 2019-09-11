//
//  CSWeatherSource.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/10/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

enum CSUnits {
    case imperial
    case international
}

enum CSWeatherSource: Int {
    case forecastIO
    case weatherUnderground
    case other
    
    func buildURL(with unitType: CSUnits, location: CSLocation) -> String {
        return String(format: self.baseURL, location.latitude, location.longitude, self.unitsCode(for: unitType))
    }
}

private extension CSWeatherSource {
    var apiKey: String {
        switch self {
        case .forecastIO:
            return "845f2bc9019ba09f0e063b33c222ec79"
        case .weatherUnderground:
            return "deeb3935adcc4c46ab3935adcc7c4675"
        default:
            return ""
        }
    }
    
    var baseURL: String {
        switch self {
        case .forecastIO:
            return "https://api.darksky.net/forecast/\(self.apiKey)/%f,%f?units=%@"
        case .weatherUnderground:
            return "https://api.weather.com/v3/wx/forecast/daily/7day?geocode=%f,%f&format=json&units=%@&language=en-US&apiKey=\(self.apiKey)"
        default:
            return ""
        }
    }
    
    func unitsCode(for unitType: CSUnits) -> String {
        switch (self, unitType) {
        case (.forecastIO, .imperial):
            return "us"
        case (.forecastIO, .international):
            return "si"
        case (.weatherUnderground, .imperial):
            return "e"
        case (.weatherUnderground, .international):
            return "m"
        default:
            return ""
        }
    }
}
