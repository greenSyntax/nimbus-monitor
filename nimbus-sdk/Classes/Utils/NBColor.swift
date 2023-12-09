//
//  NBColor.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 05/09/23.
//

import UIKit

extension UIColor {
    
    static let appWhite = UIColor.white
    static let appPurpal = UIColor.fromHex(hex: "#8e44ad")
    static let appBlack = UIColor.fromHex(hex: "#2c3e50")
    static let appBlackOff = UIColor.fromHex(hex: "#1E272C")
    static let appBlackLight = UIColor.fromHex(hex: "#1A2228")
    static let appBlue = UIColor.fromHex(hex: "#2980b9")
    static let appGreen = UIColor.fromHex(hex: "#27ae60")

}

extension UIColor {
    
    static func fromHex(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
