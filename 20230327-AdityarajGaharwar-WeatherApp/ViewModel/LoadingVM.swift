//
//  LoadingVM.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 28/03/23.
//

import Foundation
import Network
import CoreLocation

/* This class is used for checking the preconditoing and showing the controller accordingly */
class LoadingVM: NSObject {
    
    var showLoading: (()->())?
    var hideLoading: (()->())?
    var showError: (()->())?
    var loadWeatherController: ((_ cityName:String?)->())?
    var loadPermissionController: (()->())?
    //var weather = WeatherModel()
    
    
    private let locationManager = CLLocationManager()
    private let monitor = NWPathMonitor()
    
    func checkFirstStart(){
        showLoading?()
        CityResource.shared.getCity()
        if  UserDefaults.standard.value(forKey: Keys.firstStart) == nil {
            loadPermissionController?()
        } else {
            checkNetwork()
        }
    }
    
    private func checkNetwork(){
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                if self.locationManager.authorizationStatus == .denied {
                    self.getWeather()
                } else {
                    self.getWeather()
                }
            } else {
                DispatchQueue.main.async {
                    self.showError?()
                }
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
    }

    private func getWeather() {
        let defaults = UserDefaults.standard
        if defaults.value(forKey: Keys.city) != nil {
            self.hideLoading?()
            self.loadWeatherController?(defaults.value(forKey: Keys.city) as? String)
        } else {
            self.hideLoading?()
            self.loadWeatherController?(nil)
        }
    }
}

