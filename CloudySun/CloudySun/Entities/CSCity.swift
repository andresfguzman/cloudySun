//
//  CSCity.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

final class CSCity {
    let location: CSLocation
    let name: String
    
    init(location: CSLocation, name: String) {
        self.location = location
        self.name = name
    }
}
