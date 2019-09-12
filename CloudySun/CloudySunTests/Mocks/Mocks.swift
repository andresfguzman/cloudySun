//
//  Mocks.swift
//  CloudySunTests
//
//  Created by Andrés Guzmán on 9/11/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation
@testable import CloudySun

struct Mocks {
    static var mockedWeather: Weather {
        let currently = Currently(time: 0.0, icon: "0", summary: "Simple summary", temperature: 40.0)
        var dailyReadings = [DailyReading]()
        
        dailyReadings.append(DailyReading(time: 0.0, icon: "rain", summary: "Some summary", temperatureMax: 60.0, temperatureMin: 30.0))
        dailyReadings.append(DailyReading(time: 0.0, icon: "rain", summary: "Some summary", temperatureMax: 60.0, temperatureMin: 30.0))
        dailyReadings.append(DailyReading(time: 0.0, icon: "rain", summary: "Some summary", temperatureMax: 60.0, temperatureMin: 30.0))
        dailyReadings.append(DailyReading(time: 0.0, icon: "rain", summary: "Some summary", temperatureMax: 60.0, temperatureMin: 30.0))
        
        let daily = Daily(data: dailyReadings)
        return Weather(currently: currently, daily: daily)
    }
}
