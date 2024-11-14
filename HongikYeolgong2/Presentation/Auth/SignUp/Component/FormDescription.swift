//
//  FormDescription.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/15/24.
//

import SwiftUI

struct FormDescription: View {
    let message: String
    let color: Color
    
    var body: some View {
        Text(message)
            .font(.pretendard(size: 12, weight: .regular))
            .foregroundStyle(color)
            .padding(.top, 4.adjustToScreenHeight)
    }
}
