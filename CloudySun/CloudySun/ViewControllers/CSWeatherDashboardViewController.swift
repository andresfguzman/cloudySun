//
//  CSWeatherDashboardViewController.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/9/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import UIKit

protocol DashboardView: class {
    func updateUI(with weatherInfo: CSWeather)
    func loadingView(_ isLoading: Bool)
}

class CSWeatherDashboardViewController: CSBaseViewController {
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentWeatherLabel: UILabel!
    @IBOutlet weak var dailyWeatherTableView: UITableView!
    @IBOutlet weak var headerLabel: UILabel!
    
    var presenter: CSWeatherDashboardPresenter!
    var weatherForecast: CSWeather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CSWeatherDashboardPresenter(repository: CSForecastRepositoryImpl(), service: CSForecastWebService(endpoint: AppConstants.shared.selectedEndpoint))
        presenter.view = self
        dailyWeatherTableView.delegate = self
        dailyWeatherTableView.dataSource = self
        
        presenter.loadWeatherData()
    }
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: AppConstants.shared.mainStoryBoardIdentifier, bundle: nil)
        let targetVC = storyboard.instantiateViewController(withIdentifier: AppConstants.shared.editVCIdentifier) as! ConfigViewController
        targetVC.delegate = self
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
}

extension CSWeatherDashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecast?.daily.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dailyWeatherTableView.dequeueReusableCell(withIdentifier: AppConstants.shared.weatherCellIdentifier, for: indexPath) as! WeatherTableViewCell
        if let weatherForecast = weatherForecast {
            let viewModel = CSDailyReadingViewModel(with: weatherForecast.daily.data[indexPath.row])
            cell.configure(with: viewModel)
        }
        
        return cell
    }
}

extension CSWeatherDashboardViewController: DashboardView {
    func loadingView(_ isLoading: Bool) {
        if isLoading {
            self.showLoadingView()
        } else {
            self.hideLoadingView()
        }
    }
    
    func updateUI(with weatherInfo: CSWeather) {
        weatherForecast = weatherInfo
        dailyWeatherTableView.reloadData()
        currentWeatherIcon.image = UIImage(named: weatherForecast?.currently.icon ?? "na.png")
        headerLabel.text = "Right now at \(AppConstants.shared.selectedCity.name)"
        currentWeatherLabel.text = "\(weatherForecast?.currently.temperature ?? 0.0)°\n\(weatherForecast?.currently.summary ?? "")"
    }
}

extension CSWeatherDashboardViewController: SettingsViewDelegate {
    func reloadDashboard() {
        presenter.service = AppConstants.shared.selectedEndpoint == .forecastIO ? CSForecastWebService(endpoint: AppConstants.shared.selectedEndpoint) : CSWeatherUndergroundWebService(endpoint: AppConstants.shared.selectedEndpoint)
        self.presenter.loadWeatherData()
    }
}
