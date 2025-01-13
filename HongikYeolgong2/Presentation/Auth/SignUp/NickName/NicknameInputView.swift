//
//  NicknameInputView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/6/25.
//

import SwiftUI

struct NicknameInputView: View {
    @Binding var nickname: String
    let nicknameState: NicknameState
    @FocusState var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 10.adjustToScreenWidth) {
            HStack {
                TextField(
                    "닉네임을 입력해주세요",
                    text: $nickname
                )
                .focused($isFocused)
                .foregroundColor(.gray200)
                .padding(.leading, 16)
                Image(.close)
                    .padding(.trailing, 14)
                    .onTapGesture {
                        nickname = ""
                    }
                    .opacity(!nickname.isEmpty && isFocused ? 1 : 0)
            }
            .frame(maxHeight: 48.adjustToScreenHeight)
            .background(.gray800)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(nicknameState.textColor)
                    .opacity(isFocused ? 1 : 0)
            )
            
            Button {
                // 닉네임 중복 확인 이벤트 추가 가능
            } label: {
                Text("중복확인")
                    .foregroundStyle(nicknameState == .validFormatPending ? Color.white : Color.gray200)
                    .frame(maxWidth: 88.adjustToScreenWidth, maxHeight: 48.adjustToScreenHeight)
            }
            .background(nicknameState == .validFormatPending ? Color.blue100 : Color.blue400)
            .disabled(nicknameState != .validFormatPending)
            .cornerRadius(8)
        }
    }
}
