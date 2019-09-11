//
//  WeatherTableViewCell.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/10/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayWeatherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(with weatherInfo: DailyReading?) {
        if let dailyWeather = weatherInfo {
            weekDayLabel.text = "\(dailyWeather.time)"
            dayWeatherLabel.text = "Min: \(dailyWeather.temperatureMin)*\nMax: \(dailyWeather.temperatureMax)*\n\(dailyWeather.summary)"
        }
    }
}
