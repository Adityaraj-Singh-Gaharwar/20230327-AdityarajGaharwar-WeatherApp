//
//  CityManager.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 30/03/23.
//

import Foundation

/* class used to get the city data from json file */
class CityManager {
    
    static let shared = CityManager()
    private init () {}

    func getCity(compelition: @escaping ([CityModel]) -> ()) {
        
        guard let path = Bundle.main.path(forResource: "usaCities", ofType: "json") else { return }
       
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let object = try JSONDecoder().decode([CityModel].self, from: data)
            DispatchQueue.main.async {
                compelition(object)
            }
        } catch {
            print("Can't parse cities \(error.localizedDescription)")
        }
    }
}
