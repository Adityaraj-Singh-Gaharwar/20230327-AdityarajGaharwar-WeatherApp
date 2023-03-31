//
//  SearchVM.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 31/03/23.
//

import Foundation
import CoreLocation

/* This class is used sort the cities according to user input and to populate tableview in CitySerachVC */
protocol SearchVMDelegate {
    func didReceiveCity(_ city: String, _ state: String)
    func didReceiveLocation(_ lat: String, _ long: String)
}

struct SearchCellViewModel {
    var city: String
    var state: String
}

class SearchVM {
    //MARK: - vars/lets
    var reloadTablView: (()->())?
    var searchVMdelegate: SearchVMDelegate?
    private let locationManager = CLLocationManager()
    private var lat: String?
    private var lon: String?
    private var filteredCities = [CityModel]()
    private var cellViewModel = [SearchCellViewModel]() {
        didSet {
            self.reloadTablView?()
        }
    }
    
    var numberOfCell: Int {
        if filteredCities.count > 20 {
            return 20
        } else if filteredCities.count > 0 {
            return filteredCities.count
        } else {
            return 1
        }
    }
    
    //MARK: - flow func
    func getCity() {
        CurrentLocation.sharedInstance.getCurrentLocation { latitude , longitude in
            if latitude != "0.0" && longitude != "0.0" {
                self.lat = latitude
                self.lon = longitude
            } else {
                self.lat = "37.33"
                self.lon = "-122.03"
            }
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if filteredCities.isEmpty {
            if locationManager.authorizationStatus != .denied {
                self.searchVMdelegate?.didReceiveLocation(lat!, lon!)
            }
        } else {
            self.searchVMdelegate?.didReceiveCity(filteredCities[indexPath.row].city , filteredCities[indexPath.row].state)
        }
    }
    
    func searchCity(text: String) {
        guard let cities = CityResource.shared.cities else { return }
        
        filteredCities = cities.filter({ (obj: CityModel) in
            if text.count > 2 && obj.city.lowercased().contains(text.lowercased()) {
                return true
            }
            return false
        })
        filteredCities.sort(by: {$0.city.count < $1.city.count})
        createCell()
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> SearchCellViewModel {
        return cellViewModel[indexPath.row]
    }
    
    func filteredCityIsEmpty() -> Bool {
        filteredCities.isEmpty
    }
    
    private func createCell(){
        var viewModelCell = [SearchCellViewModel]()
        for city in filteredCities {
            viewModelCell.append(SearchCellViewModel(city: city.city, state: city.state))
        }
        cellViewModel = viewModelCell
    }
    
}
