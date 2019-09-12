//
//  MockedRepository.swift
//  CloudySunTests
//
//  Created by Andrés Guzmán on 9/11/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation
@testable import CloudySun

final class MockedRepository: CSForecastRepository {
    
    enum Invocation: Int {
        case initialization
        case listForecast
        case saveCacheData
    }
    
    var invocations: [Invocation] = []
    var mockedResponse: ForecastServiceResponse? = .success(weatherInfo: Mocks.mockedWeather)
    var saveStatus: SaveStatus = .success
    
    init() {
        invocations.append(.initialization)
    }
    
    func listForecast(completion: @escaping ForecastCallback) {
        invocations.append(.listForecast)
        completion(mockedResponse)
    }
    
    func saveCacheData(with weatherObject: CSWeather, completion: @escaping (SaveStatus) -> Void) {
        invocations.append(.saveCacheData)
        completion(saveStatus)
    }
}
