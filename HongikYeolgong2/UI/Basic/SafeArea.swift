//
//  SafeArea.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/5/24.
//

import UIKit

final class SafeAreaHelper {
    private init() {}
    
    /// 상단 safeArea 크기를 가져옵니다.
    /// - Returns: CGFloat
    static func safeAreaBottomInset() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            return bottomPadding ??  0.0
        } else {
            return 0.0
        }
    }
    
    /// 하단 safeArea 크기를 가져옵니다.
    /// - Returns: CGFloat
    static func safeAreaTopInset() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.top
            return bottomPadding ??  0.0
        } else {
            return 0.0
        }
    }
    
    /// SafeArea를 포함한 스크린높이를 가져옵니다.
    /// - Returns: CGFloat
    static func getFullScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height + safeAreaBottomInset() + safeAreaTopInset()
    }
    
    static func getFullScreenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    /// 현재 기기에 적용된  탭바의 높이를 가져옵니다.
    /// - Returns: CGFloat
    static func getBarBarHeight() -> CGFloat {
        let defaultTabBarHeight: CGFloat = 56
        return defaultTabBarHeight + safeAreaBottomInset()
    }
}
