//
//  CSWeatherDashboardPresenter.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/11/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import Foundation

final class CSWeatherDashboardPresenter {
    
    var service: CSService
    let repository: CSRepository
    var useCase: GetForecastUseCase!
    weak var view: DashboardView?
    
    init(repository: CSRepository, service: CSService) {
        self.repository = repository
        self.service = service
    }
    
    func loadWeatherData() {
        useCase = GetForecastUseCase(repository: repository, service: service)
        view?.loadingView(true)
        useCase.execute(with: AppConstants.shared.selectedCity.location) { [weak self] (response) in
            if let result = response {
                switch result {
                case .success(let weatherInfo):
                    self?.view?.updateUI(with: weatherInfo)
                    self?.view?.loadingView(false)
                case .failure:
                    // This would mean that not even a local data was able to be retrieved.
                    self?.view?.loadingView(false)
                    print("Failure")
                }
            }
        }
    }
}
