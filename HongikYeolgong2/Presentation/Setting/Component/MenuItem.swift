//
//  MenuItem.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/13/24.
//

import SwiftUI

struct MenuItem<Content: View>: View {
    let title: String
    let onTap: () -> ()
    let content: (() -> Content)?
    
    var body: some View {
        Button(action:onTap
               , label: {
            Text(title)
                .font(.pretendard(size: 16, weight: .regular))
                .foregroundStyle(Color.gray200)
                .minimumScaleFactor(0.2)
                .frame(maxWidth: .infinity,
                       minHeight: 52.adjustToScreenHeight,
                       alignment: .leading)
                .padding(.leading, 16.adjustToScreenWidth)
            
            content?()
                .padding(.trailing, 11)
        })
        .background(Color.gray800)
        .cornerRadius(8)
    }
}

#Preview {
    MenuItem(title: "", onTap: {}, content: { EmptyView() })
}
