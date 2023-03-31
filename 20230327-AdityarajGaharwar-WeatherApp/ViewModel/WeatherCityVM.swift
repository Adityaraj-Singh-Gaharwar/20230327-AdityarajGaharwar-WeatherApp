//
//  WeatherCityVM.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 31/03/23.
//

import Foundation

/* This class is used to get response from resource and then pass it to WeatherVC */
protocol WeatherCityVMDelegate {
    func didReceiveWeatherCityResponse(weatherResponse: WeatherCityModel?, err: NetworkError?)
}

class WeatherCityVM {
    var weatherCityVmDelegate : WeatherCityVMDelegate?
    
    func getWeatherDetailsFor(cityName: String) {
        // use WeatherResource to call API
        let weatherResource = WeatherResource()
        //LoadingIndicator.sharedInstance.showActivityIndicator()
        weatherResource.getWeatherByCity(name: cityName) { result, err in
            self.weatherCityVmDelegate?.didReceiveWeatherCityResponse(weatherResponse: result, err: err)
        }
    }
}

