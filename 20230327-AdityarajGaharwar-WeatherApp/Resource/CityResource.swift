//
//  CityResource.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 30/03/23.
//

import Foundation

/* Singleton class used to get cities */
class CityResource {
    
    var cities: [CityModel]?
    
    static let shared = CityResource()
    private init () {}
    
    func getCity() {
       let queue = DispatchQueue(label: "com.getad95.cityResponse")
       queue.async {
          CityManager.shared.getCity { [weak self] newCity in
              self?.cities = newCity
          }
       }
    }
}
