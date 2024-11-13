//
//  MenuItem.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/13/24.
//

import SwiftUI

struct MenuItem<Content: View>: View {
    let title: String
    var onTap: (() -> ())?
    let content: (() -> Content)?
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundStyle(Color.gray200)
                
                Spacer()
                
                content?()
            }
            .padding(.horizontal, 16.adjustToScreenWidth)
            .padding(.vertical, 13.adjustToScreenWidth)
        }
        .frame(height: 52.adjustToScreenHeight)
        .background(Color.gray800)
        .cornerRadius(8)
        .onTapGesture {
            onTap?()
        }
    }
}

#Preview {
    MenuItem(title: "", onTap: {}, content: { EmptyView() })
}
