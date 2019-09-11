//
//  CSWeatherViewModel.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/10/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

struct CSDailyReadingViewModel {
    let weekDay: String
    let icon: String
    let summary: String
    
    init(with weather: CSDailyReading) {
        self.weekDay = weather.weekDay
        self.icon = "\(weather.icon).png"
        self.summary = "Min: \(weather.temperatureMin)°\nMax: \(weather.temperatureMax)°\n\(weather.summary)"
    }
}
