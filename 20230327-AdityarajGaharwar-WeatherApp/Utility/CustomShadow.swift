//
//  CustomShadow.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 30/03/23.
//

import Foundation
import UIKit

class CustomShadowView: UIView{
    override func layoutSubviews() {
        super.layoutSubviews()
        DispatchQueue.main.async {
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.white.cgColor
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = self.frame.height / 8
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
}
