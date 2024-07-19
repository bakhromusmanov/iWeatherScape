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

