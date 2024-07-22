//
//  WeatherAnimation.swift
//  iWeatherScape
//
//  Created by Bakhrom Usmanov on 21/07/24.
//

import UIKit

class WeatherAnimation {
    
    func startSunAnimation(sunImageView: UIImageView, cloudImageViews: [UIImageView]) {
        animateSunRotation(sunImageView)
        animateViewHorizontalMovement(viewToMove: cloudImageViews[0], duration: 4, delay: 0, reverse: true)
        animateViewHorizontalMovement(viewToMove: cloudImageViews[1], duration: 5, delay: 0.5, reverse: false)
        animateViewHorizontalMovement(viewToMove: cloudImageViews[2], duration: 6, delay: 1, reverse: true)
    }
    
    func startCloudyAnimation(cloudImageViews: [UIImageView]) {
        animateViewHorizontalMovement(viewToMove: cloudImageViews[0], duration: 4, delay: 0, reverse: true)
        animateViewHorizontalMovement(viewToMove: cloudImageViews[1], duration: 5, delay: 0.5, reverse: false)
        animateViewHorizontalMovement(viewToMove: cloudImageViews[2], duration: 6, delay: 1, reverse: true)
    }
    
    func startThunderAnimation(cloudImageViews: [UIImageView]) {
        animateViewHorizontalMovement(viewToMove: cloudImageViews[0], duration: 4, delay: 0, reverse: true)
        animateViewHorizontalMovement(viewToMove: cloudImageViews[1], duration: 5, delay: 0.5, reverse: false)
        animateViewHorizontalMovement(viewToMove: cloudImageViews[2], duration: 6, delay: 1, reverse: true)
    }
    
    func startFogAnimation(fogImageViews: [UIImageView]) {
        animateViewHorizontalMovement(viewToMove: fogImageViews[0], duration: 4, delay: 0, reverse: true)
        animateViewHorizontalMovement(viewToMove: fogImageViews[1], duration: 5, delay: 0.5, reverse: false)
    }
    
    func startRainAnimation(cloudImageViews: [UIImageView], dropImageViews: [UIImageView]) {
        animateViewHorizontalMovement(viewToMove: cloudImageViews[0], duration: 4, delay: 0, reverse: true)
        animateViewHorizontalMovement(viewToMove: cloudImageViews[1], duration: 5, delay: 0.5, reverse: false)
        animateViewHorizontalMovement(viewToMove: cloudImageViews[2], duration: 6, delay: 1, reverse: true)
        for (index, dropImageView) in dropImageViews.enumerated() {
            animateViewDownMovement(viewToMove: dropImageView, duration: 4 + TimeInterval(index % 3), delay: TimeInterval(index % 3))
        }
    }
    
    func startSnowAnimation(snowImageViews: [UIImageView]) {
        animateViewDownMovement(viewToMove: snowImageViews[0], duration: 4, delay: 0)
        animateViewDownMovement(viewToMove: snowImageViews[1], duration: 5, delay: 1)
        animateViewDownMovement(viewToMove: snowImageViews[2], duration: 4, delay: 0.5)
    }
    
    private func animateSunRotation(_ viewToRotate: UIImageView) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = 10.0
        rotationAnimation.repeatCount = .infinity
        viewToRotate.layer.add(rotationAnimation, forKey: "rotate")
    }
    
    private func animateViewHorizontalMovement(viewToMove: UIImageView, duration: TimeInterval, delay: TimeInterval, reverse: Bool) {
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
    
    private func animateViewDownMovement(viewToMove: UIImageView, duration: TimeInterval, delay: TimeInterval) {
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
}

