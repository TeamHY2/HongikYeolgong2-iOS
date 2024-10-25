//
//  GradientBackground.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/25/24.
//

import SwiftUI

struct GradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Image(.iOSBackground)
                .resizable()
                .ignoresSafeArea(.all)
                .frame(maxWidth: .infinity, minHeight: SafeAreaHelper.getFullScreenHeight())
                .allowsHitTesting(false)
            )
    }
}


