//
//  ForecastWeatherViewController.swift
//  Weathery
//
//  Created by TheGIZzz on 22/5/2565 BE.
//

import UIKit

class ForecastWeatherViewController: UITableViewController {
    
    private var forecastWeather: [ForecastWeatherList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.register(ForecastCollectionTableViewCell.self, forCellReuseIdentifier: ForecastCollectionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        
        let city = UserDefaults.standard.string(forKey: "SelectedCity") ?? ""
        print("City Forecast:", city)
        
        Webservice.shared.getForecastWeather(city: city, completion: {
            [weak self] (result) in
            switch result {
            case .Success(let vm):
                self?.forecastWeather = vm
            
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .Error(let error):
                print("Fail to fetch the weather: \(error)")
            }
            
            print(result)
        })
        
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        forecastWeather = []
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let title = forecastWeather[section].weekDay else { return "" }
        return title
    }

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 50, height: header.bounds.height)
        header.textLabel?.textColor = .black
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return forecastWeather.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCollectionTableViewCell.identifier, for: indexPath) as? ForecastCollectionTableViewCell else {
            return UITableViewCell()
        }
        
        print("PPPP check forecastWeather ---> \(forecastWeather[indexPath.row])")
        
        cell.configure(with: forecastWeather[indexPath.section])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
