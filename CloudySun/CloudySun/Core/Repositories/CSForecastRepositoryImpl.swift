//
//  CSForecastRepositoryImpl.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

final class CSForecastRepositoryImpl: CSForecastRepository {
    func listForecast(with location: CSLocation, completion: @escaping ForecastCallback) {
        print("Executed list forecast from repository.")
        completion(nil)
    }
}
