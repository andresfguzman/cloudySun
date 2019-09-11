//
//  UseCaseImpl.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

class UseCaseImpl {
    let repository: CSRepository
    let service: CSService
    
    required init(repository: CSRepository, service: CSService) {
        self.repository = repository
        self.service = service
    }
}
