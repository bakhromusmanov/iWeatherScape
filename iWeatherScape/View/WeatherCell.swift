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
        case NSLocalizedString("sun", comment: "Weather condition: sunny"):
            imageView.tintColor = .orange
        case NSLocalizedString("rain", comment: "Weather condition: rainy"):
            imageView.tintColor = .blue
        case NSLocalizedString("snow", comment: "Weather condition: snowy"):
            imageView.tintColor = .white
        case NSLocalizedString("thunderstorm", comment: "Weather condition: thunderstorm"):
            imageView.tintColor = .purple
        case NSLocalizedString("fog", comment: "Weather condition: foggy"):
            imageView.tintColor = .darkGray
        case NSLocalizedString("cloudy", comment: "Weather condition: cloudy"):
            imageView.tintColor = .lightGray
        default:
            imageView.tintColor = .systemGray2
        }
    }
}
