//
//  Font+Uikit.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/4/24.
//

import UIKit

extension UIFont {
    static func pretendard(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "Pretendard"
        
        var weightString: String
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
        
        return UIFont(name: "\(familyName)-\(weightString)", size: size) ?? .systemFont(ofSize: size, weight: weight)
    }
    
    static func suite(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        let familyName = "SUITE"
       
        var weightString: String
        switch weight {
        case .black:
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
        
        return UIFont(name: "\(familyName)-\(weightString)", size: size) ?? .systemFont(ofSize: size, weight: weight)
    }
}
