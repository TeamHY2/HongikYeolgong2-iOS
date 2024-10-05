//
//  LineHeight.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/4/24.
//

import SwiftUI
import UIKit

extension View {
    // lineHeight - fontHeight = spacing
    // lineHeight - fontHeight / 2
    
    // UIFont로 높이를 구하고 다시 Font로 변경
    // UIFont -> Font는 가능 그 반대는 불가능
    func font(_ font: UIFont, lineHeight: CGFloat = 0) -> some View {
        let fontHeight = font.lineHeight
        
        return self
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - fontHeight) / 2)
    }
}
