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
        let times = dictionary["validTimeUtc"] as! [NSNumber]
        let maxTemps = dictionary["temperatureMax"] as! [NSNumber]
        let minTemps = dictionary["temperatureMin"] as! [NSNumber]
        let narratives = dictionary["narrative"] as! [String]
        
        let dayPart = dictionary["daypart"] as! [Any]
        let icons = iconsForDay(dayPart: dayPart)
        
        let currently = Currently(time: times[0].doubleValue, icon: icons[0], summary: narratives[0], temperature: minTemps[0].doubleValue)
        var dailyReadings = [DailyReading]()
        for n in 1...times.count - 1 {
            dailyReadings.append(DailyReading(time: times[n].doubleValue, icon: icons[n - 1], summary: narratives[n], temperatureMax: maxTemps[n].doubleValue, temperatureMin: minTemps[n].doubleValue))
        }
        return Weather(currently: currently, daily: Daily(data: dailyReadings))
    }
    
    // Build only daylight icons
    private static func iconsForDay(dayPart: [Any]) -> [String] {
        let dayPartDict = dayPart[0] as! [String: Any]
        let dayOrNight = dayPartDict["dayOrNight"] as! [String?]
        let icons = dayPartDict["iconCode"] as! [NSNumber?]
        var stringIcons = [String]()
        
        for i in 0...dayOrNight.count - 1 {
            if let dayTime = dayOrNight[i] {
                if dayTime.elementsEqual("D") {
                    stringIcons.append(icons[i]?.stringValue ?? "na")
                }
            }
        }
        
        return stringIcons
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
