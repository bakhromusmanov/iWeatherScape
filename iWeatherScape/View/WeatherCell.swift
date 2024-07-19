//
//  WeatherCollectionViewCell.swift
//  iWeatherScape
//
//  Created by Bakhrom Usmanov on 18/07/24.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func changeColor(){
        switch titleLabel.text {
        case "Sun":
            imageView.tintColor = .orange
        case "Rain":
            imageView.tintColor = .blue
        case "Snow":
            imageView.tintColor = .white
        case "Thunderstorm":
            imageView.tintColor = .purple
        case "Fog":
            imageView.tintColor = .darkGray
        case "Cloudy":
            imageView.tintColor = .lightGray
        default:
            imageView.tintColor = .systemGray2
        }
    }
}
