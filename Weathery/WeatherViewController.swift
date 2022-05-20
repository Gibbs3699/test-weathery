//
//  WeatherViewController.swift
//  Weathery
//
//  Created by TheGIZzz on 20/5/2565 BE.
//

import UIKit

class WeatherViewController: UIViewController {

    private let background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 0.5)
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 1.0).cgColor
        view.backgroundBlur(withStyle: .dark)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }


}

extension WeatherViewController {
    
    private func setupConstraints() {
        view.addSubview(background)
        view.addSubview(containerView)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // background
        NSLayoutConstraint.activate([        background.topAnchor.constraint(equalTo: view.topAnchor),
             background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // containerView
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 200),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
