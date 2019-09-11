//
//  CSForecastWebService.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation
import Alamofire

final class CSForecastWebService: CSForecastService {
    
    var endpoint: CSWeatherSource
    
    init(endpoint: CSWeatherSource) {
        self.endpoint = endpoint
    }
    
    func getForecast(with location: CSLocation, completion: @escaping (ServiceResponse<CSWeather>) -> Void) -> DataRequest {
        let url = AppConstants.shared.selectedEndpoint.buildURL(with: AppConstants.shared.selectedUnitSystem, location: location)
        let request = AF.request(url).responseDecodable { (response: DataResponse<Weather, AFError>) in
            switch response.result {
            case .success:
                if let weather = response.value {
                    completion(.success(response: weather))
                } else {
                    completion(.failure)
                }
            case .failure:
                completion(.failure)
            }
        }
        return request
    }
}
