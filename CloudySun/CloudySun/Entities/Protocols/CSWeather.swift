//
//  CSWeather.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/10/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

protocol CSWeather {
    var currently: Currently {get}
    var daily: Daily {get}
}

protocol CSCurrently {
    var time: Double {get}
    var summary: String {get}
    var temperature: Double {get}
}

protocol CSDailyReading {
    var time: Double {get}
    var summary: String {get}
    var temperatureMax: Double {get}
    var temperatureMin: Double {get}
}
