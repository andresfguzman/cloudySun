//
//  GetForecastUseCase.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

final class GetForecastUseCase: UseCaseImpl, GetForecast {
    func execute(with location: CSLocation, completion: @escaping ForecastCallback) {
        (service as! CSForecastService).getForecast(with: location) { [weak self] (response) in
            switch response {
            case .success(let forecastData):
                (self?.repository as! CSForecastRepository).saveCacheData(with: forecastData, completion: { (status) in
                    if status == .success {
                        completion(.success(weatherInfo: forecastData))
                    } else {
                        completion(.failure)
                    }
                })
            case .failure:
                (self?.repository as! CSForecastRepository).listForecast(completion: { (response) in
                    if let response = response {
                        switch response {
                        case .success(let weatherInfo):
                            completion(.success(weatherInfo: weatherInfo))
                        case .failure:
                            completion(.failure)
                        }
                    } else {
                        completion(.failure)
                    }
                })
            }
        }
    }
}
