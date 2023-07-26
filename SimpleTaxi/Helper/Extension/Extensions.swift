//
//  Extensions.swift
//  SimpleTaxi
//
//  Created by Poovarasan K on 20/07/23.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UITextField {
    
    func customTextField() {
        
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemBlue.cgColor
        self.layer.cornerRadius = 10
        self.layer.cornerCurve = .continuous
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 20))
        self.leftView = paddingView
        self.leftViewMode = .always
                
        _ = UITextField()
        self.font = UIFont.systemFont(ofSize: 20)
    }
}

extension UILabel {
    
    func stackViewLabelDesign() {
        
        self.layer.masksToBounds = true
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 30
        self.layer.cornerCurve = .continuous
        self.layer.borderColor = UIColor.red.cgColor

    }
}


