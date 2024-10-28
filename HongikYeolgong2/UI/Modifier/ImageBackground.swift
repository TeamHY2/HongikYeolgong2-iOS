//
//  ImageBackground.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/25/24.
//

import SwiftUI

struct ImageBackground: ViewModifier {
    let imageName: ImageResource
    
    func body(content: Content) -> some View {
        content
            .background(
                Image(imageName)
                    .resizable()
                    .frame(maxWidth: .infinity, minHeight: 52.adjustToScreenHeight)
            )
    }
}

