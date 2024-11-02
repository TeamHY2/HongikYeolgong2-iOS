//
//  IOSBackground.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import SwiftUI

struct IOSBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Image(.iOSBackground)
                .resizable()
                .ignoresSafeArea(.all)
                .frame(maxWidth: .infinity)
                .allowsHitTesting(false)
            )
    }
}
