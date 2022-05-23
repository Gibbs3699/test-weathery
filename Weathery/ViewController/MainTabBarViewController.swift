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
        
        
        let vc1 = UINavigationController(rootViewController: RootViewController())
        let vc2 = UINavigationController(rootViewController: ForecastWeatherViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        
        vc1.title = "Current Weather"
        vc2.title = "Forecase Weather"
        
        tabBar.backgroundColor = .clear
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
        
        setViewControllers([vc1, vc2], animated: true)
    }
    
    
    private func setupConstraints() {
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: self.tabBar.bounds.minY - 5, width: self.tabBar.bounds.width - 60, height: self.tabBar.bounds.height + 20), cornerRadius: (self.tabBar.frame.width/2)).cgPath
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
        self.tabBar.itemWidth = 120
        self.tabBar.itemPositioning = .centered
    }
}
