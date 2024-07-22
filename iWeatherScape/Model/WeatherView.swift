//
//  WeatherView.swift
//  iWeatherScape
//
//  Created by Bakhrom Usmanov on 21/07/24.
//

import UIKit

class WeatherView {
    var views: [UIView]
    var currentView: UIView?
    
    init(views: [UIView]) {
        self.views = views
    }
    
    func setViewVisibility(_ enabledView: UIView) {
        for view in views {
            view.isHidden = true
        }
        enabledView.isHidden = false
    }
    
    func switchView(fromView: UIView, toView: UIView) {
        guard fromView !== toView else {
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

