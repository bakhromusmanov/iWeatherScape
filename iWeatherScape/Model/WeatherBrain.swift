//
//  WeatherBrain.swift
//  iWeatherScape
//
//  Created by Bakhrom Usmanov on 21/07/24.
//

import UIKit

class WeatherBrain {
    var weatherData: [Weather] = []
    var selectedCell: WeatherCell?

    init() {
        weatherData = [
            Weather(image: UIImage(systemName: K.sunImageTitle)!, title: NSLocalizedString("sun", comment: "Weather condition: sunny")),
            Weather(image: UIImage(systemName: K.rainImageTitle)!, title: NSLocalizedString("rain", comment: "Weather condition: rainy")),
            Weather(image: UIImage(systemName: K.thunderstormImageTitle)!, title: NSLocalizedString("thunderstorm", comment: "Weather condition: thunderstorm")),
            Weather(image: UIImage(systemName: K.fogImageTitle)!, title: NSLocalizedString("fog", comment: "Weather condition: foggy")),
            Weather(image: UIImage(systemName: K.snowImageTitle)!, title: NSLocalizedString("snow", comment: "Weather condition: snowy")),
            Weather(image: UIImage(systemName: K.cloudyImageTitle)!, title: NSLocalizedString("cloudy", comment: "Weather condition: cloudy"))
        ]
    }

    func selectRandomCell(_ collectionView: UICollectionView) {
        let indices = 0..<weatherData.count
        let randomIndex = indices.randomElement()!
        let indexPath = IndexPath(item: randomIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        collectionView.layoutIfNeeded()
        collectionView.reloadItems(at: indices.map { IndexPath(item: $0, section: 0) })
        if let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell {
            selectCell(cell)
        }
    }
    
    func selectCell(_ cell: WeatherCell) {
        checkCellSelection(cell)
        // Animate the selection
        UIView.animate(withDuration: 0.3) {
            cell.contentView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell.titleLabel.alpha = 0.8
            cell.imageView.tintColor = cell.changeColor()?.withAlphaComponent(0.6)
            cell.backgroundColor = .systemGray5
        }
    }
    
    func deselectCell(_ cell: WeatherCell) {
        UIView.animate(withDuration: 0.3) {
            cell.contentView.transform = .identity
            cell.titleLabel.alpha = 1.0
            cell.imageView.tintColor = cell.changeColor()
            cell.backgroundColor = .clear
        }
    }
    
    func checkCellSelection(_ cell: WeatherCell){
        // Deselect the previously selected cell
        if let selectedCell = self.selectedCell {
            deselectCell(selectedCell)
        }
        //Set cell as selected
        selectedCell = cell
    }
}
