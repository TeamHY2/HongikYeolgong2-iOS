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
            .background(
                ZStack {
                    Color(red: 12/255, green: 13/255, blue: 17/255)
                        .ignoresSafeArea()

                    Image(.iOSBackground)
                        .resizable()
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity)
                        .allowsHitTesting(false)
                }
            )
    }
}
