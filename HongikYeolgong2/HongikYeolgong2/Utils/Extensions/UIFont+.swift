//
//  UIFont+.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/20/25.
//

import UIKit

extension UIFont {
    static func pretendard(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Pretendard"
        
        let weightString: String
        switch weight {
        case .black:
            weightString = "Black"
        case .bold:
            weightString = "Bold"
        case .heavy:
            weightString = "ExtraBold"
        case .ultraLight:
            weightString = "ExtraLight"
        case .light:
            weightString = "Light"
        case .medium:
            weightString = "Medium"
        case .regular:
            weightString = "Regular"
        case .semibold:
            weightString = "SemiBold"
        case .thin:
            weightString = "Thin"
        default:
            weightString = "Regular"
        }
        
        return UIFont(name: "\(familyName)-\(weightString)", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    static func suite(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "SUITE"
        
        let weightString: String
        switch weight {
        case .extrabold:
            weightString = "ExtraBold"
        case .bold:
            weightString = "Bold"
        case .medium:
            weightString = "Medium"
        case .semibold:
            weightString = "Semibold"
        default:
            weightString = "Regular"
        }
        
        return UIFont(name: "\(familyName)-\(weightString)", size: size) ?? UIFont.systemFont(ofSize: size, weight: weight)
    }
}

extension UIFont.Weight {
    static var extrabold: UIFont.Weight {
        return .black
    }
}
