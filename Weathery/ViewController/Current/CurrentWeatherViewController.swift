//
//  RootViewController.swift
//  Weathery
//
//  Created by TheGIZzz on 22/5/2565 BE.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    private var settingUnitViewModel = SettingUnitViewModel()
    private var weatherView = CurrentWeatherView()
    
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var latitude : CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
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
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        setupConstraints()
        
        searchTextField.delegate = self
        
        UserDefaults.standard.set("metric", forKey: "unit")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userDefaults =  UserDefaults.standard
        let city = userDefaults.string(forKey: "SelectedCity") ?? ""
        
        if let lat = userDefaults.string(forKey: "lat"),  let lon = userDefaults.string(forKey: "lon"){
            loadDataUsingCoordinates(lat: lat, lon: lon)
        } else {
            loadCuerrentWeather(city: city)
        }

    }
    
    @objc func searchPressed(sender: UIButton) {
        if let city = searchTextField.text {
            
            loadCuerrentWeather(city: city.escaped())
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        let location = locations[0].coordinate
        latitude = location.latitude
        longitude = location.longitude
        
        let userDefaults =  UserDefaults.standard
        userDefaults.set(latitude, forKey: "lat")
        userDefaults.set(longitude, forKey: "lon")
    
        loadDataUsingCoordinates(lat: latitude.description, lon: longitude.description)
    }
    
    private func loadCuerrentWeather(city: String) {
        Webservice.shared.getCurrentWeather(city: city, completion: {
            [weak self] (result) in
            switch result {
            case .Success(let vm):
                self?.weatherView.configure(with: CurrentWeatherViewModel(conditionId: vm.weather[0].id, cityName: vm.name, temperature: vm.main.temp, humidity:  vm.main.humidity, conditionDescription: vm.weather[0].description))
                
                    let userDefaults =  UserDefaults.standard
                    userDefaults.set(nil, forKey: "lat")
                    userDefaults.set(nil, forKey: "lon")
                
            case .Error(let error):
                print("Fail to fetch the weather: \(error)")
            }
        })
    }
    
    func loadDataUsingCoordinates(lat: String, lon: String) {
        Webservice.shared.getCurrentLocationWeather(lat: lat, lon: lon) {
 
            [weak self] (result) in
            switch result {
            case .Success(let vm):
                self?.weatherView.configure(with: CurrentWeatherViewModel(conditionId: vm.weather[0].id, cityName: vm.name, temperature: vm.main.temp, humidity:  vm.main.humidity, conditionDescription: vm.weather[0].description))
                
                UserDefaults.standard.set("\(vm.name.escaped())", forKey: "SelectedCity")
                
            case .Error(let error):
                print("Fail to fetch the weather: \(error)")
            }
        }
    }

}

// MARK: - Setup Constraints

extension CurrentWeatherViewController {
    
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
            weatherView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
             weatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        // rootContainerView
        let currentScreenType = UIDevice.current.screenType
        if currentScreenType == UIDevice.ScreenType.iPhones_5_5s_5c_SE {
            // rootContainerView
            rootContainerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
             rootContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30).isActive = true
        }else if currentScreenType == UIDevice.ScreenType.iPhones_6_6s_7_8 {
            rootContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            rootContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 30).isActive = true
        }else {
            rootContainerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            rootContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
        rootContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        rootContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

//MARK: - UITextFieldDelegate

extension CurrentWeatherViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        }else {
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
    
}
