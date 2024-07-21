//
//  ViewController.swift
//  iWeatherScape
//
//  Created by Bakhrom Usmanov on 18/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let weatherBrain = WeatherBrain()
    
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
        weatherBrain.selectRandomCell(collectionView)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherBrain.weatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.cellIdentifier, for: indexPath) as! WeatherCell
        cell.titleLabel.text = weatherBrain.weatherData[indexPath.row].title
        cell.imageView.image = weatherBrain.weatherData[indexPath.row].image
        cell.imageView.tintColor = cell.changeColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell {
            weatherBrain.selectCell(cell)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell {
            // Animate the deselection
            weatherBrain.deselectCell(cell)
        }
    }
}


