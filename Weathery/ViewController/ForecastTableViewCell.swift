//
//  ForecastTableViewCell.swift
//  Weathery
//
//  Created by TheGIZzz on 22/5/2565 BE.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    static let identifier = "ForecastTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
