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
    var icon: String {get}
    var summary: String {get}
    var temperature: Double {get}
}

protocol CSDailyReading {
    var time: Double {get}
    var icon: String {get}
    var summary: String {get}
    var temperatureMax: Double {get}
    var temperatureMin: Double {get}
}

extension CSDailyReading {
    var weekDay: String {
        let date = Date(timeIntervalSince1970: self.time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: date)
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
