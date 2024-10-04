//
//  Font+.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

extension Font {
    static func pretendard(size: CGFloat, weight: Font.Weight) -> Font {
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
        
        return .custom("\(familyName)-\(weightString)", size: size)
    }
}

extension Font {
    static func suite(size fontsize: CGFloat, weight: Font.Weight) -> Font {
        let familyName = "SUITE"
       
        var weightString: String
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
        return .custom("\(familyName)-\(weightString)", size: fontsize)
    }
}

extension Font.Weight {
    static var extrabold: Font.Weight {
        return .black
    }
}
