//
//  MenuButton.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/12/25.
//

import SwiftUI

enum MenuButtonType: Equatable {
    case basic
    case toggle
}

struct MenuButton: View {
    let title: String
    let action: () -> Void
    let type: MenuButtonType
    @State var isOn: Bool = true
    
    init(title: String, action: @escaping () -> Void, type: MenuButtonType = .basic, isOn: Bool = true) {
        self.title = title
        self.action = action
        self.type = type
        self.isOn = isOn
    }
    
    var body: some View {
        switch type {
            case .basic:
                Button {
                    action()
                } label: {
                    HStack{
                        Text(title)
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundStyle(.gray200)
                        Spacer()
                        Image(.arrowRight)
                    }
                    .padding(.leading, 16.adjustToScreenWidth)
                    .padding(.trailing, 11.adjustToScreenWidth)
                    .padding(.vertical, 13.adjustToScreenWidth)
                }
                .frame(height: 52.adjustToScreenHeight)
                .background(Color.gray800)
                .cornerRadius(8)
            case .toggle:
                Toggle("열람실 종료 시간 알림", isOn: $isOn)
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundStyle(.gray200)
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue100))
                    .padding(.leading, 16.adjustToScreenWidth)
                    .padding(.trailing, 14.adjustToScreenWidth)
                    .padding(.vertical, 13.adjustToScreenWidth)
                    .frame(height: 52.adjustToScreenHeight)
                    .background(Color.gray800)
                    .cornerRadius(8)
                    .onChange(of: isOn) { _ in
                        action()
                    }
        }
    }
}
