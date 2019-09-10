//
//  CSWeather.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

protocol CSWeather {
    var timezone: String {get}
    var currently: Currently {get}
    var daily: Daily {get}
}

struct Weather: Codable, CSWeather {
    internal var timezone: String
    internal var currently: Currently
    internal var daily: Daily
}

protocol CSCurrently {
    var time: Double {get}
    var summary: String {get}
    var temperature: Double {get}
}

struct Currently: Codable, CSCurrently {
    internal var time: Double
    internal var summary: String
    internal var temperature: Double
}

protocol CSDailyReading {
    var time: Double {get}
    var summary: String {get}
    var temperatureMax: Double {get}
    var temperatureMin: Double {get}
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
