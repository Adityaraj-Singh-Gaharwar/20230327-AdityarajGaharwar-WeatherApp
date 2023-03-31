//
//  WaetherLatLongModel.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 29/03/23.
//

import Foundation

// MARK: - CityModelModel
struct CityModel : Codable {
	let city : String
	let state : String

	enum CodingKeys: String, CodingKey {

		case city = "city"
		case state = "state"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)!
        state = try values.decodeIfPresent(String.self, forKey: .state)!
	}

}
