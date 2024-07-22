//
//  ViewController.swift
//  iWeatherScape
//
//  Created by Bakhrom Usmanov on 18/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    //Colection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Weather Views
    @IBOutlet weak var sunView: UIView!
    @IBOutlet weak var cloudyView: UIView!
    @IBOutlet weak var fogView: UIView!
    @IBOutlet weak var rainView: UIView!
    @IBOutlet weak var thunderView: UIView!
    @IBOutlet weak var snowView: UIView!
    
    var weatherViews: [UIView]?
    var currentView: UIView?
    
    //Animation Sun Elements
    @IBOutlet weak var sunImageView1: UIImageView!
    @IBOutlet weak var cloudSunImageView1: UIImageView!
    @IBOutlet weak var cloudSunImageView2: UIImageView!
    @IBOutlet weak var cloudSunImageView3: UIImageView!
    
    //Animation Snow Elements
    @IBOutlet weak var SnowImageView1: UIImageView!
    @IBOutlet weak var SnowImageView2: UIImageView!
    @IBOutlet weak var SnowImageView3: UIImageView!
    @IBOutlet weak var SnowImageView4: UIImageView!
    
    //Animation Fog Elements
    @IBOutlet weak var fogImageView2: UIImageView!
    @IBOutlet weak var fogImageView1: UIImageView!

    //Animation Thunder Elements
    @IBOutlet weak var thunderDarkCloud1: UIImageView!
    @IBOutlet weak var thunderDarkCloud3: UIImageView!
    @IBOutlet weak var thunderDarkCloud2: UIImageView!
    
    //Animation Cloudy Elements
    @IBOutlet weak var cloudyCloud1: UIImageView!
    @IBOutlet weak var cloudyCloud2: UIImageView!
    @IBOutlet weak var cloudyCloud3: UIImageView!
    
    //Animation Rain Elements
    @IBOutlet weak var rainDarkCloud1: UIImageView!
    @IBOutlet weak var rainDarkCloud2: UIImageView!
    @IBOutlet weak var rainDarkCloud3: UIImageView!
    @IBOutlet weak var rainDrop1: UIImageView!
    @IBOutlet weak var rainDrop2: UIImageView!
    @IBOutlet weak var rainDrop3: UIImageView!
    @IBOutlet weak var rainDrop4: UIImageView!
    @IBOutlet weak var rainDrop5: UIImageView!
    @IBOutlet weak var rainDrop6: UIImageView!
    @IBOutlet weak var rainDrop7: UIImageView!
    @IBOutlet weak var rainDrop8: UIImageView!
    
    let weatherBrain = WeatherBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        title = K.appName
        
        // Register WeatherCell xib
        collectionView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellWithReuseIdentifier: K.cellIdentifier)
        
        
        //Animation
        startSunAnimation()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weatherViews = [sunView, rainView, thunderView, fogView, snowView, cloudyView]
        if let weatherViews = weatherViews {
            let index = weatherBrain.selectRandomCell(collectionView)
            setViewVisability(weatherViews[index])
            currentView = weatherViews[index]
        }
    }
    
    func setViewVisability(_ enabledView: UIView){
        // Set the initial state of the views
        sunView.isHidden = true
        cloudyView.isHidden = true
        fogView.isHidden = true
        rainView.isHidden = true
        thunderView.isHidden = true
        snowView.isHidden = true
        
        enabledView.isHidden = false
    }
    
    
    func startSunAnimation(){
        //Animation Sun
        animateSunRotation(sunImageView1)
        animateViewHorizontalMovement(viewToMove: cloudSunImageView1, duration: 4, delay: 0, reverse: true)
        animateViewHorizontalMovement(viewToMove: cloudSunImageView2, duration: 5, delay: 0.5, reverse: false)
        animateViewHorizontalMovement(viewToMove: cloudSunImageView3, duration: 6, delay: 1, reverse: true)
    }
    
    func animateSunRotation(_ viewToRotate: UIImageView) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue =  CGFloat.pi * 2
        rotationAnimation.duration = 10.0
        rotationAnimation.repeatCount = .infinity
        viewToRotate.layer.add(rotationAnimation, forKey: "rotate")
    }
    
    func animateViewHorizontalMovement(viewToMove: UIImageView, duration: TimeInterval, delay: TimeInterval, reverse: Bool) {
        let screenWidth = UIScreen.main.bounds.width
        let viewWidth = viewToMove.bounds.width
        
        let fromValue = screenWidth + viewWidth
        let toValue = -viewWidth
        
        let movementAnimation = CABasicAnimation(keyPath: "position.x")
        movementAnimation.fromValue = reverse ? toValue : fromValue
        movementAnimation.toValue = reverse ? fromValue : toValue
        movementAnimation.duration = duration
        movementAnimation.autoreverses = true
        movementAnimation.repeatCount = .infinity
        movementAnimation.beginTime = CACurrentMediaTime() + delay
        
        viewToMove.layer.add(movementAnimation, forKey: "move")
    }
    
    func animateViewDownMovement(viewToMove: UIImageView, duration: TimeInterval, delay: TimeInterval) {
        let screenHeight = UIScreen.main.bounds.height
        let viewHeight = viewToMove.bounds.height
        
        let fromValue = -viewHeight
        let toValue = screenHeight + viewHeight
        
        let movementAnimation = CABasicAnimation(keyPath: "position.y")
        movementAnimation.fromValue = fromValue
        movementAnimation.toValue = toValue
        movementAnimation.duration = duration
        movementAnimation.repeatCount = .infinity
        movementAnimation.beginTime = CACurrentMediaTime() + delay
        
        viewToMove.layer.add(movementAnimation, forKey: "move")
    }
    
    func switchView(fromView: UIView, toView: UIView) {
        
        if fromView == toView{
            return
        }
        // Set the initial state of the views
        fromView.alpha = 1.0
        toView.alpha = 0.0
        toView.isHidden = false
        
        // Animate the transition
        UIView.animate(withDuration: 0.5, animations: {
            fromView.alpha = 0.0
            toView.alpha = 1.0
        }, completion: { _ in
            fromView.isHidden = true
        })
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
        cell.layer.cornerRadius = 20.0
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell,
           let weatherViews = weatherViews {
            weatherBrain.selectCell(cell)
            
            // Switch the weather view
            if let currentView = self.currentView {
                switchView(fromView: currentView, toView: weatherViews[indexPath.row])
            }
            
            // Update the current weather view
            self.currentView = weatherViews[indexPath.row]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? WeatherCell {
            weatherBrain.deselectCell(cell)
        }
    }
}


