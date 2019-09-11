//
//  CSWeather.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

struct Weather: Codable, CSWeather {
    internal var currently: Currently
    internal var daily: Daily
    
    static func buildWeatherObject(with dictionary: [String: Any]) -> CSWeather {
        let days = dictionary["dayOfWeek"] as! [String]
        let maxTemps = dictionary["temperatureMax"] as! [NSNumber]
        let minTemps = dictionary["temperatureMin"] as! [NSNumber]
        let narratives = dictionary["narrative"] as! [String]
        let currently = Currently(time: 0.0, summary: narratives[0], temperature: minTemps[0].doubleValue)
        var dailyReadings = [DailyReading]()
        for n in 1...days.count - 1 {
            dailyReadings.append(DailyReading(time: 0.0, summary: narratives[n], temperatureMax: maxTemps[n].doubleValue, temperatureMin: minTemps[n].doubleValue))
        }
        return Weather(currently: currently, daily: Daily(data: dailyReadings))
    }
}

struct Currently: Codable, CSCurrently {
    internal var time: Double
    internal var summary: String
    internal var temperature: Double
}

struct DailyReading: Codable, CSDailyReading {
    internal var time: Double
    internal var summary: String
    internal var temperatureMax: Double
    internal var temperatureMin: Double
}

struct Daily: Codable {
    let data: [DailyReading]
}
