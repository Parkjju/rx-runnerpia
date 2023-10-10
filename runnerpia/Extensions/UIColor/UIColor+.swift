//
//  UIColor+.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/10.
//

import UIKit

extension UIColor {
    static var blue200: UIColor {
        return UIColor(hex: "#B1DEFD")
    }
    static var blue400: UIColor {
        return UIColor(hex: "#3B8DED")
    }
    static var blue500: UIColor {
        return UIColor(hex: "#005EE2")
    }
    static var orange200: UIColor {
        return UIColor(hex: "#FFD4B5")
    }
    static var grey100: UIColor {
        return UIColor(hex: "#F2F2F2")
    }
    static var grey200: UIColor {
        return UIColor(hex: "#DFDFDF")
    }
    static var grey300: UIColor {
        return UIColor(hex: "#C1C1C1")
    }
    static var grey400: UIColor {
        return UIColor(hex: "#A5A5A5")
    }
    static var grey500: UIColor {
        return UIColor(hex: "#8B8B8B")
    }
    static var grey600: UIColor {
        return UIColor(hex: "#6F6F6F")
    }
    static var grey700: UIColor {
        return UIColor(hex: "#555555")
    }
    static var grey800: UIColor {
        return UIColor(hex: "#3D3D3D")
    }
    static var grey900: UIColor {
        return UIColor(hex: "#242424")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
