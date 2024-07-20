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
    
    func changeColor() -> UIColor? {
        switch titleLabel.text {
        case NSLocalizedString("sun", comment: "Weather condition: sunny"):
            return .orange
        case NSLocalizedString("rain", comment: "Weather condition: rainy"):
            return .blue
        case NSLocalizedString("snow", comment: "Weather condition: snowy"):
            return .white
        case NSLocalizedString("thunderstorm", comment: "Weather condition: thunderstorm"):
            return .purple
        case NSLocalizedString("fog", comment: "Weather condition: foggy"):
            return .darkGray
        case NSLocalizedString("cloudy", comment: "Weather condition: cloudy"):
            return .lightGray
        default:
            return .systemGray2
        }
    }
}
