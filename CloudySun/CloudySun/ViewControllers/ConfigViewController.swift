//
//  ConfigViewController.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/10/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var sourceSegment: UISegmentedControl!
    @IBOutlet weak var unitsSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.citiesTableView.dataSource = self
        self.citiesTableView.delegate = self
        
        self.sourceSegment.selectedSegmentIndex = AppConstants.shared.selectedEndpoint.rawValue
        if AppConstants.shared.selectedUnitSystem == .international {
            self.unitsSegment.selectedSegmentIndex = 1
        } else {
            self.unitsSegment.selectedSegmentIndex = 0
        }
        
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if self.unitsSegment.selectedSegmentIndex == 0 {
            AppConstants.shared.selectedUnitSystem = .imperial
        } else {
            AppConstants.shared.selectedUnitSystem = .international
        }
        
        AppConstants.shared.selectedEndpoint = CSWeatherSource(rawValue: self.sourceSegment.selectedSegmentIndex) ?? .forecastIO
        
        self.navigationController?.popViewController(animated: true)
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
        let cell = self.citiesTableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath)
        let cellCity = AppConstants.shared.cities[indexPath.row]
        cell.textLabel?.text = cellCity.name
        
        if cellCity.name.elementsEqual(AppConstants.shared.selectedCity.name) {
            cell.setSelected(true, animated: true)
        }
        
        return cell
    }

}
