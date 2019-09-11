//
//  CSWeatherUndergroundWebService.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/10/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation
import Alamofire

final class CSWeatherUndergroundWebService: CSForecastService {
    
    var endpoint: CSWeatherSource
    
    init(endpoint: CSWeatherSource) {
        self.endpoint = endpoint
    }
    
    func getForecast(with location: CSLocation, completion: @escaping (ServiceResponse<CSWeather>) -> Void) -> DataRequest {
        let url = AppConstants.shared.selectedEndpoint.buildURL(with: AppConstants.shared.selectedUnitSystem, location: location)
        let request = AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success:
                let weatherResponse = Weather.buildWeatherObject(with: response.value as! [String: Any])
                completion(.success(response: weatherResponse))
            case .failure:
                completion(.failure)
            }
        }
        return request
    }
}
