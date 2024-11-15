//
//  Form.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/15/24.
//

import SwiftUI

struct FormTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.suite(size: 18, weight: .bold))
            .foregroundStyle(.gray100)
            .frame(
                maxWidth: .infinity,
                maxHeight: 52.adjustToScreenHeight,
                alignment: .leading
            )
            .background(Color.black)
    }
}

struct FormLabel: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.pretendard(size: 16, weight: .bold), lineHeight: 26)
            .foregroundStyle(.gray200)
    }
}

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
