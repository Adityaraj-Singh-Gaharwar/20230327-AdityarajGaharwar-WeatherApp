//
//  CurrentLocationCell.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 31/03/23.
//

import UIKit

/* This class is used for getting current location in CitySerachVC */
class CurrentLocationCell: UITableViewCell {

    @IBOutlet weak var imgLocation: UIImageView!
    @IBOutlet weak var lblCurrentLocation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        self.lblCurrentLocation.text = "Use current location"
    }

}
