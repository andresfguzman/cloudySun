//
//  ConfigViewController.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/10/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: class {
    func reloadDashboard()
}

class ConfigViewController: CSBaseViewController {
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var sourceSegment: UISegmentedControl!
    @IBOutlet weak var unitsSegment: UISegmentedControl!
    
    weak var delegate: SettingsViewDelegate?
    var selectedCity: CSCity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.citiesTableView.dataSource = self
        self.citiesTableView.delegate = self
        
        self.sourceSegment.selectedSegmentIndex = AppConstants.shared.selectedEndpoint.rawValue
        self.unitsSegment.selectedSegmentIndex = AppConstants.shared.selectedUnitSystem.rawValue
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        AppConstants.shared.selectedUnitSystem = CSUnits(rawValue: self.unitsSegment.selectedSegmentIndex) ?? .imperial
        AppConstants.shared.selectedEndpoint = CSWeatherSource(rawValue: self.sourceSegment.selectedSegmentIndex) ?? .forecastIO
        AppConstants.shared.selectedCity = self.selectedCity ?? AppConstants.shared.selectedCity
        self.navigationController?.popViewController(animated: true)
        delegate?.reloadDashboard()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ConfigViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConstants.shared.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.citiesTableView.dequeueReusableCell(withIdentifier: AppConstants.shared.cityCellIdentifier, for: indexPath)
        let cellCity = AppConstants.shared.cities[indexPath.row]
        cell.textLabel?.text = cellCity.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCity = AppConstants.shared.cities[indexPath.row]
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
