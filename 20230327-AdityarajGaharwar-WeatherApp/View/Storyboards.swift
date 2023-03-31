//
//  Storyboards.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 28/03/23.
//

import Foundation
import UIKit

/* This class is used to call various controller present in different storyboards */
class Storyboards {
    class func Main(controller: String) -> UIViewController {
        return UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: controller)
    }
}
