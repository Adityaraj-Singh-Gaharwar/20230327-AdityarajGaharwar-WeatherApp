//
//  WeatherVC.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 29/03/23.
//

import UIKit
/* This class is used for showing weather data received from APIs */
class WeatherVC: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var ImgBackground: UIImageView!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var lblCurrentTamp: UILabel!
    @IBOutlet weak var lblMaxMin: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblFeelsLike: UILabel!
    @IBOutlet weak var lblAirpressuer: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblVisibilty: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblCloud: UILabel!
    
    //MARK: - Variables
    private var weatherVM = WeatherVM()
    private var weatherCityVM = WeatherCityVM()
    var latitude: String?
    var longitude: String?
    var cityName: String?
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: Keys.firstStart)
        backgroundImageAnimate()
        weatherVM.WeatherVmDelegate = self
        weatherCityVM.weatherCityVmDelegate = self
        if let city = cityName {
            weatherCityVM.getWeatherDetailsFor(cityName: city)
        } else if let lat = latitude, let long = longitude, lat != "0.0" && long != "0.0" {
            weatherVM.getWeatherDetailsFor(latitude: lat, longitude: long)
        } else {
            weatherVM.getWeatherDetailsFor(latitude: "40.7128", longitude: "-74.0060")
        }
    }

    //MARK: - Actions
    @IBAction func btnSearchTap(_ sender: UIButton) {
        guard let vc = Storyboards.Main(controller: Controller.CitySearch) as? CitySearchVC else {return}
        vc.viewModel.searchVMdelegate = self
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
}

//MARK: - Extensions
/* for api response */
extension WeatherVC: WeatherVMDelegate, WeatherCityVMDelegate {
    func didReceiveWeatherCityResponse(weatherResponse: WeatherCityModel?, err: NetworkError?) {
        DispatchQueue.main.async {
            if let weatherResponse = weatherResponse {
                self.lblCityName.text = weatherResponse.name
                self.lblCurrentTamp.text = "\(weatherResponse.main?.temp?.doubleToString() ?? "")°"
                self.lblMaxMin.text = "\(weatherResponse.main?.tempMax?.doubleToString() ?? "")° / \(weatherResponse.main?.tempMin?.doubleToString() ?? "")°"
                self.lblWeather.text = weatherResponse.weather?.first?.description ?? ""
                self.imgWeather.image = UIImage(named: "\(weatherResponse.weather?.first?.icon ?? "01d")-1.png")
                self.lblFeelsLike.text = "\(weatherResponse.main?.feelsLike?.doubleToString() ?? "-")°"
                self.lblAirpressuer.text = "\(weatherResponse.main?.pressure ?? 0) hPa"
                self.lblHumidity.text = "\(weatherResponse.main?.humidity ?? 0) %"
                self.lblVisibilty.text = "\(weatherResponse.visibility ?? 0) m"
                self.lblWind.text = "\(weatherResponse.wind?.speed?.doubleToString() ?? "") m/s"
                self.lblCloud.text = "\(weatherResponse.clouds?.all ?? 0) %"
                self.ImgBackground.image = UIImage(named: "\(weatherResponse.weather?.first?.icon ?? "02d")-2")
            }
        }
    }
    
    func didReceiveWeatherResponse(weatherResponse: WeatherLatLongModel?, err: NetworkError?) {
        DispatchQueue.main.async {
            if let weatherResponse = weatherResponse {
                self.lblCityName.text = weatherResponse.name
                self.lblCurrentTamp.text = "\(weatherResponse.main?.temp?.doubleToString() ?? "")°"
                self.lblMaxMin.text = "\(weatherResponse.main?.tempMax?.doubleToString() ?? "")° / \(weatherResponse.main?.tempMin?.doubleToString() ?? "")°"
                self.lblWeather.text = weatherResponse.weather?.first?.description ?? ""
                self.imgWeather.image = UIImage(named: "\(weatherResponse.weather?.first?.icon ?? "01d")-1.png")
                self.lblFeelsLike.text = "\(weatherResponse.main?.feelsLike?.doubleToString() ?? "-")°"
                self.lblAirpressuer.text = "\(weatherResponse.main?.pressure ?? 0) hPa"
                self.lblHumidity.text = "\(weatherResponse.main?.humidity ?? 0) %"
                self.lblVisibilty.text = "\(weatherResponse.visibility ?? 0) m"
                self.lblWind.text = "\(weatherResponse.wind?.speed?.doubleToString() ?? "") m/s"
                self.lblCloud.text = "\(weatherResponse.clouds?.all ?? 0) %"
                self.ImgBackground.image = UIImage(named: "\(weatherResponse.weather?.first?.icon ?? "02d")-2")
            }
        }
    }
    
    private func backgroundImageAnimate() {
        self.ImgBackground.frame.origin.x = 0
        self.ImgBackground.addImageGradient()
        UIView.animate(withDuration: 10, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.ImgBackground.frame.origin.x -= 100
        }, completion: nil)
    }
}

/* for search response */
extension WeatherVC: SearchVMDelegate {
    func didReceiveCity(_ city: String, _ state: String) {
        UserDefaults.standard.setValue(city, forKey: Keys.city)
        weatherCityVM.getWeatherDetailsFor(cityName: city)
    }
    
    func didReceiveLocation(_ lat: String, _ long: String) {
        weatherVM.getWeatherDetailsFor(latitude: lat, longitude: long)
    }
}
