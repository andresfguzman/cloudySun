//
//  ViewController.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var useCase: GetForecast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        useCase = GetForecastUseCase(repository: CSForecastRepositoryImpl(), service: CSForecastWebService(endpoint: .forecastIO))
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        useCase.execute(with: CSLocation(latitude: 37.8267, longitude: -122.4233), using: .forecastIO) { (response) in
            if let result = response {
                switch result {
                case .success(let weatherInfo):
                    print(weatherInfo)
                case .failure:
                    print("Failure")
                }
            }
        }
    }
    
}

