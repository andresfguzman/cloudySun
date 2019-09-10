//
//  CSService.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

enum ServiceResponse<Model> {
    case success(response: Model)
    case failure
}

enum Response<T> {
    case failure
    case notConnectedToInternet
    case success(objects: [T])
}

protocol CSService {
    var endpoint: CSWeatherSource { get set }
}
