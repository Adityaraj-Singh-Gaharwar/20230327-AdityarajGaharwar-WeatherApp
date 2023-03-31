//
//  WeatherResource.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 29/03/23.
//

import Foundation

/* Used to call the Weather APIs using webservice functions */
struct WeatherResource {
    // callin API using lat long
    func getWeatherBy(lat: String, long: String,completion: @escaping (_ result: WeatherLatLongModel?, _ err: NetworkError?) -> Void) {
        let utility = HttpUtility.shared
        let weatherLatLongUrl = URL(string: APIEndpoints.baseUrl)!
        var components = URLComponents(url: weatherLatLongUrl, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "lat", value: lat),
                                  URLQueryItem(name: "lon", value: long),
                                  URLQueryItem(name: "units", value: "metric"),
                                  URLQueryItem(name: "appid", value: Keys.weatherApiKey)]
        let weatherLatLongRequest = Request(withUrl: (components?.url!)!, forHttpMethod: .get)
        utility.request(huRequest: weatherLatLongRequest, resultType: WeatherLatLongModel.self) { (response) in
            switch response {
            case .success(let weatherResult):
                if let weather = weatherResult {
                    completion(weather, nil)
                } else {
                    completion(nil, nil)
                }
            case .failure(let error):
                // your code here to handle error
                DispatchQueue.main.async {
                    completion(nil, error)
                    // your code here to handle error
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // Calling API using city name
    func getWeatherByCity(name: String, completion: @escaping (_ result: WeatherCityModel?, _ err: NetworkError?) -> Void) {
        let utility = HttpUtility.shared
        let weatherCityUrl = URL(string: APIEndpoints.baseUrl)!
        var components = URLComponents(url: weatherCityUrl, resolvingAgainstBaseURL: false)
        components?.queryItems = [URLQueryItem(name: "q", value: name),
                                  URLQueryItem(name: "units", value: "metric"),
                                  URLQueryItem(name: "appid", value: Keys.weatherApiKey)]
        let weatherCityRequest = Request(withUrl: (components?.url!)!, forHttpMethod: .get)
        utility.request(huRequest: weatherCityRequest, resultType: WeatherCityModel.self) { (response) in
            switch response {
            case .success(let weatherCityResult):
                if let weather = weatherCityResult {
                    completion(weather, nil)
                } else {
                    completion(nil, nil)
                }
            case .failure(let error):
                // your code here to handle error
                DispatchQueue.main.async {
                    completion(nil, error)
                    // your code here to handle error
                    print(error.localizedDescription)
                }
            }
        }
    }
}
