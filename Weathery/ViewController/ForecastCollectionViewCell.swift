//
//  ForecastTableViewCell.swift
//  Weathery
//
//  Created by TheGIZzz on 22/5/2565 BE.
//

import UIKit
import SDWebImage

class ForecastCollectionViewCell: UICollectionViewCell {

    static let identifier = "ForecastTableViewCell"
    
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
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let hourlyTimeLabel: UILabel = {
       let label = UILabel()
        label.text = "05:00"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let tempSymbol: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let temperatureLabel: UILabel = {
       let label = UILabel()
        label.text = "32"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let humidityLabel: UILabel = {
       let label = UILabel()
        label.text = "32"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: WeatherInfo) {
//        print("PPPP get date ----> \(item.icon)")
    
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        if let date = dateFormatterGet.date(from: item.time) {
            hourlyTimeLabel.text = dateFormatter.string(from: date)
        }

        temperatureLabel.text = String(item.temp)
        humidityLabel.text = String(item.humidity)
        
        guard let url = URL(string: "http://openweathermap.org/img/wn/\(item.icon)@2x.png") else {return}
        print("check random image ---> \(url)")

        tempSymbol.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(item.icon)@2x.png")
        
        
//        tempSymbol.sd_setImage(with: url)
        
//        configureImage(with: ForecastWeatherViewModel(weekDay: nil, hourlyForecast: nil, conditionId: item.id))
    }
    
//    func configureImage(with vm: ForecastWeatherViewModel) {
//
//        DispatchQueue.main.async { [weak self] in
//            self?.tempSymbol.image = UIImage(named: vm.conditionName)
//        }
//    }
    
}

extension ForecastCollectionViewCell {
    
    private func setupConstraints() {
        horizontalStackView.addArrangedSubview(temperatureLabel)
        horizontalStackView.addArrangedSubview(humidityLabel)
        rootStackView.addArrangedSubview(hourlyTimeLabel)
        rootStackView.addArrangedSubview(tempSymbol)
        rootStackView.addArrangedSubview(horizontalStackView)
        addSubview(rootStackView)
        
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        hourlyTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        tempSymbol.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            // rootStackView
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
}

