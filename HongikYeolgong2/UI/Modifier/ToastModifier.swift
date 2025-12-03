//
//  ToastModifier.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 2/19/25.
//

import SwiftUI

enum ToastPosition {
    case top
    case bottom
}

struct ToastModifier: ViewModifier {
    @Binding var isToastShow: Bool
    var iconImage: Image?
    var text: String
    var position: ToastPosition
    
    
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
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignmentForPosition())
                .padding(positionPadding())
                .transition(.opacity)
                .animation(.easeOut, value: isToastShow)
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
    
    private func alignmentForPosition() -> Alignment {
        switch position {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
    
    
    private func positionPadding() -> EdgeInsets {
        switch position {
        case .top:
            return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        case .bottom:
            return EdgeInsets(top: 0, leading: 0, bottom: 18, trailing: 0)
        }
    }
}


extension View {
    func toast(isToastShow: Binding<Bool>, iconImage: Image? = nil, text: String, position: ToastPosition = .top) -> some View {
        self.modifier(ToastModifier(isToastShow: isToastShow, iconImage: iconImage, text: text, position: position))
    }
}
