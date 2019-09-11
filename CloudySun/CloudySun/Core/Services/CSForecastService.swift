//
//  CSGetForecastService.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation
import Alamofire

enum ForecastServiceResponse {
    case success(weatherInfo: CSWeather)
    case failure
}

typealias ForecastCallback = (ForecastServiceResponse?) -> Void

protocol CSForecastService: CSService {
    @discardableResult
    func getForecast(with location: CSLocation, completion: @escaping (ServiceResponse<CSWeather>) -> Void) -> DataRequest
}
