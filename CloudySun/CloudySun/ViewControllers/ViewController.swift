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
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        // Move to presenter.
        useCase = GetForecastUseCase(repository: CSForecastRepositoryImpl(), service: CSForecastWebService(endpoint: AppConstants.shared.selectedEndpoint))
        useCase.execute(with: AppConstants.shared.selectedCity.location) { (response) in
            if let result = response {
                switch result {
                case .success(let weatherInfo):
                    print(weatherInfo)
                case .failure:
                    // Execute from local db. (repository impl)
                    print("Failure")
                }
            }
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: AppConstants.shared.mainStoryBoardIdentifier, bundle: nil)
        self.navigationController?.pushViewController(storyboard.instantiateViewController(withIdentifier: AppConstants.shared.editVCIdentifier), animated: true)
    }
    
}

