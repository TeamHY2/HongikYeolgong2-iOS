//
//  HY2Button.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/24/24.
//

import SwiftUI

struct HY2Button: View {
    
    enum ButtonStyle {
        case mediumButton
        case smallButton
        case imageButton(image: ImageResource)
    }
    
    let title: String
    let action: () -> ()
    let style: ButtonStyle
    var backgroundColor: Color = .blue100
    var textColor: Color = .white
    var fontSize: CGFloat = 16
    
    init(title: String,
         textColor: Color,
         fontSize: CGFloat,
         style: ButtonStyle,
         backgroundColor: Color = .blue100,
         action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.style = style
        self.textColor = textColor
        self.fontSize = fontSize
        self.backgroundColor = backgroundColor
    }
    
    init(title: String,
         style: ButtonStyle,
         backgroundColor: Color = .blue100,
         action: @escaping () -> Void) {
        self.title = title
        self.action = action
        self.style = style
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        switch style {
        case .mediumButton:
            Button(action: {
                action()
            }, label: {
                buttonLabel
            })
            .background(backgroundColor)
            .cornerRadius(8)
        case .smallButton:
            Button(action: {
                action()
            }, label: {
                buttonLabel
            })
            .background(backgroundColor)
            .cornerRadius(4)
        case .imageButton(let image):
            Button(action: {
                action()
            }, label: {
                buttonLabel
            })
            .background(
                Image(image)
                    .resizable()
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .cornerRadius(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.blue400, lineWidth: 1)
                    )
            )
            .cornerRadius(8)
        }
    }
    
    private var buttonLabel: some View {
        switch style {
        case .smallButton:
            Text(title)
                .font(.suite(size: fontSize, weight: .semibold))
                .frame(maxWidth: .infinity, maxHeight: 44)
                .foregroundColor(textColor)
        case .mediumButton:
            Text(title)
                .font(.pretendard(size: fontSize, weight: .regular))
                .frame(maxWidth: .infinity, maxHeight: 48)
                .foregroundColor(.white)
        case .imageButton:
            Text(title)
                .font(.suite(size: fontSize, weight: .semibold))
                .frame(maxWidth: .infinity, maxHeight: 50)
                .foregroundColor(textColor)
        }
    }
}
