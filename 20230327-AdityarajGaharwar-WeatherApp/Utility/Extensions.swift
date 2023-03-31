//
//  Extensions.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 28/03/23.
//

import Foundation
import UIKit

// MARK: - UIView extensions
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            DispatchQueue.main.async {
                self.layer.cornerRadius = self.frame.height / newValue
            }
        }
    }
}

// MARK: - UIViewController extensions
extension UIViewController {
    func AlertWithOneOption(message:String, optionOne:String, actionOptionOne:@escaping() -> Void)  {
        let alert = UIAlertController.init(title: Constants.AppName, message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: optionOne, style: .default, handler: { (action) in
            actionOptionOne()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func Alert(message:String){
        let alert = UIAlertController.init(title: Constants.AppName, message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UIImageView extensions
extension UIImageView {
    func addImageGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradient.opacity =  0.9
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 0, y: 0.3)
        gradient.frame = self.bounds
        gradient.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - Double extensions
extension Double {
    func doubleToString() -> String {
        return String(format: "%.0f", self)
    }
}
