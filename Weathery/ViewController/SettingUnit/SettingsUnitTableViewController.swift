//
//  SettingUnitView.swift
//  Weathery
//
//  Created by TheGIZzz on 23/5/2565 BE.
//

import UIKit

class SettingsUnitTableViewController: UITableViewController {

    private var settingUnitViewModel = SettingUnitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(SettingUnitTableViewCell.self, forCellReuseIdentifier: SettingUnitTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        title = "Setting Unit"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.visibleCells.forEach { cell in
            cell.accessoryType = .none
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            cell.selectionStyle = .none
            
            let unit = Unit.allCases[indexPath.row]
            settingUnitViewModel.selectedUnit = unit
            
            
            let userDefaults = UserDefaults.standard
            if userDefaults.value(forKey: "unit") == nil {
                userDefaults.set(unit, forKey: "unit")
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingUnitViewModel.units.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingsItem = settingUnitViewModel.units[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingUnitTableViewCell.identifier, for: indexPath) as? SettingUnitTableViewCell else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = settingsItem.displayName
        
        return cell
        
    }

}
