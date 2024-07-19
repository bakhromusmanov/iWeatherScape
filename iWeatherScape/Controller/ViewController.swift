//
//  ViewController.swift
//  iWeatherScape
//
//  Created by Bakhrom Usmanov on 18/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let weather: [Weather] = [
        Weather(image: UIImage(systemName: K.sunImageTitle)!, title: "Sun"),
        Weather(image: UIImage(systemName: K.rainImageTitle)!, title: "Rain"),
        Weather(image: UIImage(systemName: K.thunderstormImageTitle)!, title: "Thunderstorm"),
        Weather(image: UIImage(systemName: K.fogImageTitle)!, title: "Fog"),
        Weather(image: UIImage(systemName: K.snowImageTitle)!, title: "Snow"),
        Weather(image: UIImage(systemName: K.cloudyImageTitle)!, title: "Cloudy")
        ]
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        title = K.appName
        
        collectionView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellWithReuseIdentifier: K.cellIdentifier)
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
        cell.changeColor()
        return cell
    }
}

