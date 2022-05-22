//
//  RootViewController.swift
//  Weathery
//
//  Created by TheGIZzz on 22/5/2565 BE.
//

import UIKit

class RootViewController: UIViewController {
    
    private var weatherView = WeatherView()
    
    private let background: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var rootContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 0.5)
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 0.9).cgColor
        view.backgroundBlur(withStyle: .light)
        return view
    }()
    
    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 5
        
        return stackView
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 25
        
        return stackView
    }()
    
    private var searchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "enter location...", attributes: [
            .foregroundColor: UIColor.white.withAlphaComponent(0.5),
            .font: UIFont.systemFont(ofSize: 16.0)
        ])
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 0.2)
        textField.layer.cornerRadius = 20
        textField.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor(red: 196/255, green: 39/255, blue: 251/255, alpha: 0.5), radius: 10, opacity: 0.8)
        textField.textColor = .white
        
        return textField
    }()

    private var searchButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .thin, scale: .small)
        var image = UIImage(systemName: "location.magnifyingglass", withConfiguration: config)?.withTintColor(UIColor.purple, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(searchPressed), for: .primaryActionTriggered)
        button.tintColor = .label
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 1.0).cgColor
        button.layer.cornerRadius = 30
        button.addShadow(offset: CGSize.init(width: 0, height: 5), color: UIColor(red: 196/255, green: 39/255, blue: 251/255, alpha: 0.5), radius: 10, opacity: 0.6)
        
         return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()

    }
    
    @objc func searchPressed(sender: UIButton) {
        if let city = searchTextField.text {
            Webservice.shared.getCurrentWeather(city: city, completion: {
                [weak self] (result) in
                switch result {
                case .Success(let vm):
                    self?.weatherView.configure(with: CurrentWeatherViewModel(conditionId: vm.weather[0].id, cityName: vm.name, temperature: vm.main.temp, humidity:  vm.main.humidity, conditionDescription: vm.weather[0].description))
                    
                case .Error(let error):
                    print("Fail to fetch the weather: \(error)")
                }
                
                print(result)
            })
        }
    }
    

}

extension RootViewController {
    
    private func setupConstraints() {
        view.addSubview(background)
        view.addSubview(rootContainerView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(weatherView)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        rootContainerView.translatesAutoresizingMaskIntoConstraints = false

        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // background
             background.topAnchor.constraint(equalTo: view.topAnchor),
             background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
             
            // rootContainerView
             rootContainerView.heightAnchor.constraint(equalToConstant: 200),
             rootContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
             rootContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
             rootContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // searchTextField
            searchTextField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 80),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            searchTextField.topAnchor.constraint(equalTo: rootContainerView.topAnchor, constant: 30),
            searchTextField.centerXAnchor.constraint(equalTo: rootContainerView.centerXAnchor),
            
            // conditionImageView
            searchButton.widthAnchor.constraint(equalToConstant: 70),
            searchButton.heightAnchor.constraint(equalToConstant: 70),
            searchButton.topAnchor.constraint(equalTo:        searchTextField.topAnchor, constant: -10),
            searchButton.leftAnchor.constraint(equalTo:        searchTextField.leftAnchor),
            
            // weatherView
            weatherView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
             weatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
}

