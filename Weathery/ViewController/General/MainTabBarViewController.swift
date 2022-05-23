//
//  MainTabBarViewController.swift
//  Weathery
//
//  Created by TheGIZzz on 22/5/2565 BE.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupConstraints()
        setupTabBar()
    }

}

extension MainTabBarViewController {
    
    private func setupTabBar() {
        
        
        let vc1 = UINavigationController(rootViewController: CurrentWeatherViewController())
        let vc2 = UINavigationController(rootViewController: ForecastWeatherViewController())
        let vc3 = UINavigationController(rootViewController: SettingsUnitTableViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "location.fill")
        vc2.tabBarItem.image = UIImage(systemName: "sun.haze")
        vc3.tabBarItem.image = UIImage(systemName: "sun.min")
        
        vc1.title = "Current Weather"
        vc2.title = "Forecast Weather"
        vc3.title = "Setting Unit"
        
        
        let app = UITabBarAppearance()
        app.backgroundEffect = .none
        app.shadowColor = .clear
        tabBar.standardAppearance = app
        
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
        
        setViewControllers([vc1, vc2, vc3], animated: true)
    }
    
    
    private func setupConstraints() {
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 10 , y: self.tabBar.bounds.minY - 10, width: self.tabBar.bounds.width - 30, height: self.tabBar.bounds.height + 20), cornerRadius: (self.tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 1.0).cgColor
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        self.tabBar.itemWidth = 50
        self.tabBar.itemPositioning = .centered
    }
}
