//
//  CSWeather.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

protocol CSWeather {
    var weatherIcon: String { get }
    var minTemperature: Double { get }
    var maxTemperature: Double { get }
    var weekDay: String { get }
    var smallDescription: String { get }
}
