//
//  LoadingVC.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 28/03/23.
//

import UIKit
import Lottie

/* This class is first ViewController and does the checking for data and showing the next ViewCntroller */
class LoadingVC: UIViewController {
    //MARK: - Variables
    private var animationView: LottieAnimationView?
    private var viewModel = LoadingVM()
    
    //MARK: - lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        animationView = .init(name: "sunLoad")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 2
        view.addSubview(animationView!)
        CityResource.shared.getCity()
    }

    //MARK: - flow func
    private func bind() {
        viewModel.showLoading = {
            DispatchQueue.main.async {
                self.animationView!.play()
            }
        }
        viewModel.hideLoading = {
            DispatchQueue.main.async {
                self.animationView!.stop()
            }
        }
        viewModel.showError = {
            self.AlertWithOneOption(message: "Please check Internet Connection", optionOne: "Ok") {
                self.viewModel.loadWeatherController?(nil)
            }
        }
        viewModel.loadPermissionController = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.navigationController?.pushViewController(Storyboards.Main(controller: Controller.Permission) as! PermissionVC, animated: true)
            }
        }
        viewModel.loadWeatherController = { city in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                guard let vc = Storyboards.Main(controller: Controller.Weather) as? WeatherVC else {return}
                if city != nil {
                    vc.cityName = city
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    CurrentLocation.sharedInstance.getCurrentLocation { lat, lon in
                        vc.latitude = lat
                        vc.longitude = lon
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
        viewModel.checkFirstStart()
    }
}
