//
//  ViewController.swift
//  iWeatherScape
//
//  Created by Bakhrom Usmanov on 18/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedCell: WeatherCell?
    
    let weather: [Weather] = [
        Weather(image: UIImage(systemName: K.sunImageTitle)!, title: NSLocalizedString("sun", comment: "Weather condition: sunny")),
        Weather(image: UIImage(systemName: K.rainImageTitle)!, title: NSLocalizedString("rain", comment: "Weather condition: rainy")),
        Weather(image: UIImage(systemName: K.thunderstormImageTitle)!, title: NSLocalizedString("thunderstorm", comment: "Weather condition: thunderstorm")),
        Weather(image: UIImage(systemName: K.fogImageTitle)!, title: NSLocalizedString("fog", comment: "Weather condition: foggy")),
        Weather(image: UIImage(systemName: K.snowImageTitle)!, title: NSLocalizedString("snow", comment: "Weather condition: snowy")),
        Weather(image: UIImage(systemName: K.cloudyImageTitle)!, title: NSLocalizedString("cloudy", comment: "Weather condition: cloudy"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        title = K.appName
        
        // Register WeatherCell xib
        collectionView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellWithReuseIdentifier: K.cellIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadAllCells()
        selectRandomCell()
    }
    
    
    func loadAllCells() {
        let indices = 0..<weather.count
        let randomIndex = indices.randomElement()!
        let indexPath = IndexPath(item: randomIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        collectionView.layoutIfNeeded()
        collectionView.reloadItems(at: indices.map { IndexPath(item: $0, section: 0) })
        if let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell {
            selectCell(cell)
        }
    }
    
    func selectRandomCell() {
        let randomIndexPath = IndexPath(item: Int.random(in: 0..<weather.count), section: 0)
        if let cell = collectionView.cellForItem(at: randomIndexPath) as? WeatherCell {
            selectCell(cell)
        }
    }
    
    func selectCell(_ cell: WeatherCell) {
        // Deselect the previously selected cell
        if let selectedCell = self.selectedCell {
            deselectCell(selectedCell)
        }
        
        // Animate the selection
        UIView.animate(withDuration: 0.3) {
            cell.contentView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            cell.titleLabel.alpha = 0.8
            cell.imageView.tintColor = cell.changeColor()?.withAlphaComponent(0.6)
            cell.backgroundColor = .systemGray5
        }
        
        //Set cell as selected
        selectedCell = cell
    }
    
    func deselectCell(_ cell: WeatherCell) {
        UIView.animate(withDuration: 0.3) {
            cell.contentView.transform = .identity
            cell.titleLabel.alpha = 1.0
            cell.imageView.tintColor = cell.changeColor()
            cell.backgroundColor = .clear
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as! WeatherCell
        cell.titleLabel.text = weather[indexPath.row].title
        cell.imageView.image = weather[indexPath.row].image
        cell.imageView.tintColor = cell.changeColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell {
            selectCell(cell)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell {
            // Animate the deselection
            deselectCell(cell)
        }
    }
}


