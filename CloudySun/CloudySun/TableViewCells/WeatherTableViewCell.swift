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

    func configure(with weatherInfo: CSDailyReadingViewModel?) {
        if let dailyWeather = weatherInfo {
            weekDayLabel.text = dailyWeather.weekDay
            dayWeatherLabel.text = dailyWeather.summary
            weatherIcon.image = UIImage(named: "03.png")
        }
    }
}
