//
//  WeatherView.swift
//  Weathery
//
//  Created by TheGIZzz on 20/5/2565 BE.
//

import UIKit

class CurrentWeatherView: UIView {
    
    // animation
    private var animateLeadingAnchor: NSLayoutConstraint?
    private var leadingEdgeOnScreen: CGFloat = 16
    private var leadingEdgeOffScreen: CGFloat = -1000
    
    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        
        var spacing: CGFloat = 5
        let currentScreenType = UIDevice.current.screenType
        if currentScreenType == UIDevice.ScreenType.iPhones_5_5s_5c_SE || currentScreenType == UIDevice.ScreenType.iPhones_6_6s_7_8 {
            spacing = 0
        }
        
        stackView.spacing = spacing
        
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 25
        
        return stackView
    }()
    
    private var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rain")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
        label.setImageWithText(text: "temp", leftIcon: UIImage(named: "temperature"), rightIcon: nil)
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        
        return label
    }()
    
    private var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.setImageWithText(text: "hum", leftIcon: UIImage(named: "humidity"), rightIcon: nil)
        label.textColor = .white
        
        return label
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34)
        label.text = "Location..."
        label.textColor = .white
        
        return label
    }()
    
    private var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Clear Sky"
        label.textColor = .white.withAlphaComponent(0.5)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with vm: CurrentWeatherViewModel) {

        DispatchQueue.main.async { [weak self] in
            self?.cityLabel.text = vm.cityName
            self?.temperatureLabel.text = vm.temperatureString
            self?.humidityLabel.text = vm.humidityString
            self?.conditionLabel.text = vm.conditionDescription
            self?.conditionImageView.image = UIImage(named: vm.conditionName)
            
            UserDefaults.standard.set("\(vm.cityName )", forKey: "SelectedCity")
        }
    }

}

// MARK: - Setup Constraints
extension CurrentWeatherView {
    
    private func setupConstraints() {
        rootStackView.addArrangedSubview(cityLabel)
        rootStackView.addArrangedSubview(conditionImageView)
        rootStackView.addArrangedSubview(conditionLabel)
        horizontalStackView.addArrangedSubview(temperatureLabel)
        horizontalStackView.addArrangedSubview(humidityLabel)
        rootStackView.addArrangedSubview(horizontalStackView)
        addSubview(rootStackView)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([

            // rootStackView
            rootStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
        ])
        
        // animation
        animateLeadingAnchor = rootStackView.topAnchor.constraint(equalTo: topAnchor, constant: leadingEdgeOffScreen)
        animateLeadingAnchor?.isActive = true
        
        // conditionImageView
        let currentScreenType = UIDevice.current.screenType
        if currentScreenType == UIDevice.ScreenType.iPhones_5_5s_5c_SE || currentScreenType == UIDevice.ScreenType.iPhones_6_6s_7_8 {
            conditionImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
            conditionImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        } else {
            conditionImageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
            conditionImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        }
    }
}

// MARK: - Animations

extension CurrentWeatherView {
    
    private func animate() {
        let duration = 0.5
        let animator = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
            self.animateLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.layoutIfNeeded()
        }
        
        animator.startAnimation()
    }
}
