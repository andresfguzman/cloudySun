//
//  MockedWeatherService.swift
//  CloudySunTests
//
//  Created by Andrés Guzmán on 9/11/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation
import Alamofire
@testable import CloudySun

final class MockedWeatherService: CSForecastService {
    
    enum Invocation: Int {
        case initialization
        case getForecast
    }
    
    var invocations: [Invocation] = []
    var serviceResponse = ServiceResponse<CSWeather>.success(response: Mocks.mockedWeather)
    var endpoint: CSWeatherSource
    
    init(endpoint: CSWeatherSource = .forecastIO) {
        self.endpoint = endpoint
        invocations.append(.initialization)
    }
    
    func getForecast(with location: CSLocation, completion: @escaping (ServiceResponse<CSWeather>) -> Void) {
        invocations.append(.getForecast)
        completion(serviceResponse)
    }
}
