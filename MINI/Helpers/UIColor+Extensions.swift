//
//  UIColor+Extensions.swift
//  MINI
//
//  Created by Yan Rybkin on 16.06.2023.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexWithoutSymbol = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgbValue: UInt64 = 0
        Scanner(string: hexWithoutSymbol).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
