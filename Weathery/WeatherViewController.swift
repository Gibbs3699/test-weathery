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
    
    private var rootContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 0.5)
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 0.9).cgColor
        view.backgroundBlur(withStyle: .extraLight)
        return view
    }()
    
    let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        return stackView
    }()
    
    let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 25
        
        return stackView
    }()
    
    
    private var innerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 1.0)
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        return view
    }()
    
    private var searchTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "enter location...", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16.0)
        ])
//        textField.placeholder = "enter location..."
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 0.2)
        textField.layer.cornerRadius = 20
        textField.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor(red: 196/255, green: 39/255, blue: 251/255, alpha: 0.5), radius: 10, opacity: 0.8)
        return textField
    }()
    
    private var conditionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.tintColor = .label
        return imageView
    }()
    
    private var temperatureLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 30)
////        label.text = "hum: 32"
//        label.textColor = .white
        label.setImageWithText(text: "32", leftIcon: UIImage(named: "temperature"), rightIcon: nil)
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = .white
        
        return label
    }()
    
    private var humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.setImageWithText(text: "32", leftIcon: UIImage(named: "humidity"), rightIcon: nil)
        label.textColor = .white
        
        return label
    }()
    
    private var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34)
        label.text = "Bangkok".uppercased()
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
    
    
    private var searchButton: UIButton = {
        let button = UIButton()
        var image = UIImage(named: "location")
        button.setBackgroundImage(image, for: .normal)
//        button.addTarget(self, action: #selector(searchPressed(_:)), for: .primaryActionTriggered)
        button.tintColor = .label
        button.backgroundColor =  UIColor(red: 69/255, green: 39/255, blue: 139/255, alpha: 0.9)
        button.layer.cornerRadius = 30
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 10, right: 10)
        
         return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
    }

}

extension WeatherViewController {
    
    private func setupConstraints() {
        view.addSubview(background)
        view.addSubview(rootContainerView)
        view.addSubview(innerContainerView)
        view.addSubview(searchTextField)
        rootStackView.addArrangedSubview(cityLabel)
        rootStackView.addArrangedSubview(conditionImageView)
        rootStackView.addArrangedSubview(conditionLabel)
        horizontalStackView.addArrangedSubview(temperatureLabel)
        horizontalStackView.addArrangedSubview(humidityLabel)
        rootStackView.addArrangedSubview(horizontalStackView)
        view.addSubview(rootStackView)
        view.addSubview(searchButton)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        rootContainerView.translatesAutoresizingMaskIntoConstraints = false
        innerContainerView.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        conditionImageView.translatesAutoresizingMaskIntoConstraints = false
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        
        
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
            
            // innerContainerView
            innerContainerView.heightAnchor.constraint(equalToConstant: 100),
            innerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            innerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            innerContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // rootStackView
            rootStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rootStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            // conditionImageView
            conditionImageView.widthAnchor.constraint(equalToConstant: 200),
            conditionImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // conditionImageView
            searchButton.widthAnchor.constraint(equalToConstant: 70),
            searchButton.heightAnchor.constraint(equalToConstant: 70),
            searchButton.topAnchor.constraint(equalTo:        searchTextField.topAnchor, constant: -10),
            searchButton.leftAnchor.constraint(equalTo:        searchTextField.leftAnchor)
        ])
    }
}
