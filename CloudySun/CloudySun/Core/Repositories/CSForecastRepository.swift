//
//  CSForecastRepository.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

protocol CSForecastRepository: CSRepository {
    func listForecast(completion: @escaping ForecastCallback)
    func saveCacheData(with weatherObject: CSWeather, completion: @escaping (SaveStatus) -> Void)
}
