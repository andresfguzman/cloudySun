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
        let dayPart = dictionary["daypart"] as! [Any]
        let dayPartDict = dayPart[0] as! [String: Any]
        let icons = dayPartDict["iconCode"] as! [NSNumber?]
        let currently = Currently(time: 0.0, icon: weatherUndergroundIcon(at: 0, in: icons), summary: narratives[0], temperature: minTemps[0].doubleValue)
        var dailyReadings = [DailyReading]()
        for n in 1...days.count - 1 {
            dailyReadings.append(DailyReading(time: 0.0, icon: weatherUndergroundIcon(at: n, in: icons), summary: narratives[n], temperatureMax: maxTemps[n].doubleValue, temperatureMin: minTemps[n].doubleValue))
        }
        return Weather(currently: currently, daily: Daily(data: dailyReadings))
    }
    
    private static func weatherUndergroundIcon(at index: Int, in array: [NSNumber?]) -> String {
        if let icon = array[index] {
            return icon.stringValue
        } else {
            return array[index+1]?.stringValue ?? "0"
        }
    }
}

struct Currently: Codable, CSCurrently {
    internal var time: Double
    internal var icon: String
    internal var summary: String
    internal var temperature: Double
}

struct DailyReading: Codable, CSDailyReading {
    internal var time: Double
    internal var icon: String
    internal var summary: String
    internal var temperatureMax: Double
    internal var temperatureMin: Double
}

struct Daily: Codable {
    let data: [DailyReading]
}
