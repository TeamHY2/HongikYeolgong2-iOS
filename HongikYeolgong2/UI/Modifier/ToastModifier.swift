//
//  ToastModifier.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 2/19/25.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isToastShow: Bool
    var iconImage: Image?
    var text: String
    
    
    func body(content: Content) -> some View {
        ZStack{
            content
            
            if isToastShow{
                VStack{
                    HStack(spacing: 6) {
                        if let iconImage = iconImage {
                            iconImage
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.adjustToScreenWidth, height: 20.adjustToScreenHeight)
                        }
                        Text(text)
                            .font(.suite(size: 14, weight: .medium), lineHeight: 32.adjustToScreenHeight)
                            .foregroundColor(.gray100)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 4)
                    .background(.gray800)
                    .cornerRadius(8)
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .onChange(of: isToastShow) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    isToastShow = false
                }
            }
        }
                
    }
}


extension View {
    func toast(isToastShow: Binding<Bool>, iconImage: Image? = nil, text: String) -> some View {
        self.modifier(ToastModifier(isToastShow: isToastShow, iconImage: iconImage, text: text))
    }
}
