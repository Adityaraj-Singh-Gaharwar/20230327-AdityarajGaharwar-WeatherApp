//
//  CityCell.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 31/03/23.
//

import UIKit

/* This class is used to populate cities in tableview in CitySerachVC */
class CityCell: UITableViewCell {

    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblStateName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(filteredCities: SearchCellViewModel) {
        lblCityName.text = filteredCities.city
        lblStateName.text = filteredCities.state
        self.backgroundColor = .clear
    }

}
