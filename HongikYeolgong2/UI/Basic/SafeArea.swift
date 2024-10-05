//
//  SafeArea.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/5/24.
//

import UIKit

final class SafeAreaHelper {
    private init() {}
    
    static func safeAreaBottomInset() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            return bottomPadding ??  0.0
        } else {
            return 0.0
        }
    }
    
    static func safeAreaTopInset() -> CGFloat {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.top
            return bottomPadding ??  0.0
        } else {
            return 0.0
        }
    }
    
    static func getFullScreenHeight() -> CGFloat {
        return UIScreen.main.bounds.height + safeAreaBottomInset() + safeAreaTopInset()
    }
}
