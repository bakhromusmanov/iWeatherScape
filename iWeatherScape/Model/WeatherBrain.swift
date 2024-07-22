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
            Weather(image: #imageLiteral(resourceName: "Sun Icon"), title: NSLocalizedString("sun", comment: "Weather condition: sunny")),
            Weather(image: #imageLiteral(resourceName: "Rain Icon"), title: NSLocalizedString("rain", comment: "Weather condition: rainy")),
            Weather(image: #imageLiteral(resourceName: "Thunderstorm Icon"), title: NSLocalizedString("thunderstorm", comment: "Weather condition: thunderstorm")),
            Weather(image: #imageLiteral(resourceName: "Fog Icon"), title: NSLocalizedString("fog", comment: "Weather condition: foggy")),
            Weather(image: #imageLiteral(resourceName: "Snow Icon"), title: NSLocalizedString("snow", comment: "Weather condition: snowy")),
            Weather(image: #imageLiteral(resourceName: "Cloud Icon"), title: NSLocalizedString("cloudy", comment: "Weather condition: cloudy"))
        ]
    }

    func selectRandomCell(_ collectionView: UICollectionView) -> Int {
        let indices = 0..<weatherData.count
        let randomIndex = 0
        let indexPath = IndexPath(item: randomIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        collectionView.layoutIfNeeded()
        collectionView.reloadItems(at: indices.map { IndexPath(item: $0, section: 0) })
        if let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell {
            selectCell(cell)
        }
        return randomIndex
    }
    
    func selectCell(_ cell: WeatherCell) {
        checkCellSelection(cell)
        // Animate the selection
        UIView.animate(withDuration: 0.3) {
            cell.contentView.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
            cell.titleLabel.alpha = 0.8
            //cell.imageView.tintColor = cell.changeColor()?.withAlphaComponent(0.6)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.5824528933, blue: 0.9868829846, alpha: 1)
        }
    }
    
    func deselectCell(_ cell: WeatherCell) {
        UIView.animate(withDuration: 0.3) {
            cell.contentView.transform = .identity
            cell.titleLabel.alpha = 1.0
            //cell.imageView.tintColor = cell.changeColor()
            cell.backgroundColor = #colorLiteral(red: 0.2625794067, green: 0.7076980792, blue: 1, alpha: 1)
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
