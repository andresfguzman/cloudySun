//
//  GetForecast.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

protocol GetForecast {
    func execute(with location: CSLocation, using source: CSWeatherSource, completion: @escaping ForecastCallback)
}
