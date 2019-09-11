//
//  ViewController.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var dailyWeatherTableView: UITableView!
    
    var useCase: GetForecastUseCase!
    var weatherForecast: CSWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyWeatherTableView.delegate = self
        dailyWeatherTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // Move to presenter.
        switch AppConstants.shared.selectedEndpoint {
        case .forecastIO:
            useCase = GetForecastUseCase(repository: CSForecastRepositoryImpl(), service: CSForecastWebService(endpoint: AppConstants.shared.selectedEndpoint))
        default:
            useCase = GetForecastUseCase(repository: CSForecastRepositoryImpl(), service: CSWeatherUndergroundWebService(endpoint: AppConstants.shared.selectedEndpoint))
        }
        runUseCase()
    }
    
    func runUseCase() {
        useCase.execute(with: AppConstants.shared.selectedCity.location) { [weak self] (response) in
            if let result = response {
                switch result {
                case .success(let weatherInfo):
                    self?.weatherForecast = weatherInfo
                    self?.updateUI()
                    print(weatherInfo)
                case .failure:
                    // Execute from local db. (repository impl)
                    print("Failure")
                }
            }
        }
    }
    
    private func updateUI() {
        dailyWeatherTableView.reloadData()
        currentWeatherLabel.text = "\(weatherForecast?.currently.temperature ?? 0.0)*\n\(weatherForecast?.currently.summary ?? "")"
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: AppConstants.shared.mainStoryBoardIdentifier, bundle: nil)
        self.navigationController?.pushViewController(storyboard.instantiateViewController(withIdentifier: AppConstants.shared.editVCIdentifier), animated: true)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecast?.daily.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dailyWeatherTableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        if let weatherForecast = weatherForecast {
            let viewModel = CSDailyReadingViewModel(with: weatherForecast.daily.data[indexPath.row])
            cell.configure(with: viewModel)
        }
        
        return cell
    }
}
