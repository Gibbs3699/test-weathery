//
//  ForecastCollectionTableViewCell.swift
//  Weathery
//
//  Created by TheGIZzz on 23/5/2565 BE.
//

import UIKit

class ForecastCollectionTableViewCell: UITableViewCell {

    static let identifier = "ForecastCollectionTableViewCell"
    private var dailyForecast: [WeatherInfo] = []
    
    private var forecastWeatherVM: [ForecastWeatherViewModel] = [ForecastWeatherViewModel]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ForecastCollectionViewCell.self, forCellWithReuseIdentifier: ForecastCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
}

extension ForecastCollectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyForecast.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCollectionViewCell.identifier, for: indexPath) as? ForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: dailyForecast[indexPath.row])
        cell.backgroundColor = .clear
        
        return cell
    }
    
    func configure(with item: ForecastWeatherList) {
        dailyForecast = item.hourlyForecast ?? []
        DispatchQueue.main.async {
            [weak self] in self?.collectionView.reloadData()
        }
    }
    
}
