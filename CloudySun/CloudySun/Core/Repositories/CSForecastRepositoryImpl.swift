//
//  CSForecastRepositoryImpl.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

final class CSForecastRepositoryImpl: CSForecastRepository {
    func saveCacheData(with weatherObject: CSWeather, completion: @escaping (SaveStatus) -> Void) {
        let data = try! JSONEncoder().encode(weatherObject as! Weather)
        UserDefaults.standard.set(data, forKey: AppConstants.shared.selectedCity.name)
        completion(.success)
    }
    
    func listForecast(completion: @escaping ForecastCallback) {
        let rawWeather = UserDefaults.standard.value(forKey: AppConstants.shared.selectedCity.name) as! Data
        let weatherObject = try! JSONDecoder().decode(Weather.self, from: rawWeather)
        print(weatherObject)
        completion(.success(weatherInfo: weatherObject))
    }
}
