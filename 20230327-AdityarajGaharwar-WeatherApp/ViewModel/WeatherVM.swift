//
//  WeatherVM.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 29/03/23.
//

import Foundation

/* This class is used to get response from resource and then pass it to WeatherVC */
protocol WeatherVMDelegate {
    func didReceiveWeatherResponse(weatherResponse: WeatherLatLongModel?, err: NetworkError?)
}

class WeatherVM {
    var WeatherVmDelegate : WeatherVMDelegate?
    
    func getWeatherDetailsFor(latitude: String, longitude:String) {
        // use WeatherResource to call API
        let weatherResource = WeatherResource()
        //LoadingIndicator.sharedInstance.showActivityIndicator()
        weatherResource.getWeatherBy(lat: latitude, long: longitude) { result, err in
            // return the response we get from WeatherResource
            self.WeatherVmDelegate?.didReceiveWeatherResponse(weatherResponse: result, err: err)
        }
    }
}
