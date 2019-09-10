//
//  GetForecastUseCase.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

final class GetForecastUseCase: UseCaseImpl, GetForecast {
    func execute(with location: CSLocation, using source: CSWeatherSource, completion: @escaping ForecastCallback) {
        (service as! CSForecastService).getForecast(with: location) { (response) in
            switch response {
            case .success(let forecastData):
                completion(.success(weatherInfo: forecastData))
            case .failure:
                completion(.failure)
            }
        }
    }
}
