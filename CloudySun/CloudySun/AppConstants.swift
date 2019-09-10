//
//  AppConstants.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

enum CSWeatherSource {
    case forecastIO
    case weatherBug
    case other
}

final class AppConstants: NSObject {
    
    static let shared = AppConstants()
    
    private override init() {}
    
    let forecastIOKey = "845f2bc9019ba09f0e063b33c222ec79"
    
    public func endpoint(for source: CSWeatherSource) -> String {
        switch source {
        case .forecastIO:
            return "https://api.darksky.net/forecast/\(forecastIOKey)/%f,%f"
        default:
            return ""
        }
    }
    
}
