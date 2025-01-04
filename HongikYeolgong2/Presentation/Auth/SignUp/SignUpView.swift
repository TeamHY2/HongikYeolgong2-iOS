//
//  SignUpView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/5/25.
//

import SwiftUI
import ComposableArchitecture

struct SignUpView: View {
    let store: StoreOf<SignUpFeature>
    @FocusState private var isNicknameFocused: Bool
    @FocusState private var isDepartmentFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("회원가입")
                .font(.suite(size: 18, weight: .bold))
                .foregroundStyle(.gray100)
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 52.adjustToScreenHeight,
                    alignment: .leading
                )
            
            Spacer()
                .frame(height: 32.adjustToScreenHeight)
            
            Text("닉네임")
                .font(.pretendard(size: 16, weight: .bold), lineHeight: 26)
                .foregroundStyle(.gray200)
            
            Spacer()
                .frame(height: 8.adjustToScreenHeight)
            
            HStack(spacing: 10.adjustToScreenWidth){
                HStack{
                    TextField("닉네임을 입력해주세요", text: .init(get: {
                        store.nickname
                    }, set: {
                        store.send(.inputNickname($0))
                    }))
                    .focused($isNicknameFocused)
                    .foregroundColor(.gray200)
                    .padding(.leading, 16)
                    Image(.close)
                        .padding(.trailing, 14)
                        .onTapGesture {
                            store.send(.inputNickname(""))
                        }
                        .opacity(!store.nickname.isEmpty && isNicknameFocused ? 1 : 0)
                        .animation(.easeInOut(duration: 0.1), value: store.nickname.isEmpty)
                }
                .frame(maxHeight: 48.adjustToScreenHeight)
                .background(.gray800)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(store.nicknameState.textColor)
                        .opacity(isNicknameFocused ? 1 : 0)
                )
                .animation(.easeInOut(duration: 0.1), value: isNicknameFocused)
                
                Button {
                    // 닉네임 중복 확인 이벤트 추가
                } label: {
                    Text("중복확인")
                        .foregroundStyle(store.nicknameState == .validFormatPending ? Color.white : Color.gray200)
                        .frame(maxWidth: 88.adjustToScreenWidth, maxHeight: 48.adjustToScreenHeight)
                }
                .background(store.nicknameState == .validFormatPending ? Color.blue100 : Color.blue400)
                .disabled(store.nicknameState != .validFormatPending)
                .animation(.easeInOut(duration: 0.1), value: store.nicknameState)
                .cornerRadius(8)
            }
            
            Spacer()
                .frame(height: 4.adjustToScreenHeight)
            
            Text(store.message)
                .font(.pretendard(size: 12, weight: .regular))
                .foregroundStyle(store.nicknameState.textColor)
                .animation(.easeInOut(duration: 0.1), value: store.nicknameState)
            
            Spacer()
                .frame(height: 12.adjustToScreenHeight)
            
            Text("학과")
                .font(.pretendard(size: 16, weight: .bold), lineHeight: 26)
                .foregroundStyle(.gray200)
            
            Spacer()
                .frame(height: 8.adjustToScreenHeight)
            
            HStack{
                TextField("학과를 입력해주세요", text: .init(get: {
                    store.Department
                }, set: {
                    store.send(.inputDepartment($0))
                }))
                .focused($isDepartmentFocused)
                .foregroundColor(.gray200)
                .padding(.leading, 16)
                .padding(.trailing, 8)
                Image(.close)
                    .padding(.trailing, 14)
                    .onTapGesture {
                        store.send(.inputDepartment(""))
                    }
                    .opacity(!store.Department.isEmpty && isDepartmentFocused ? 1 : 0)
                    .animation(.easeInOut(duration: 0.1), value: store.Department.isEmpty)
            }
            .frame(maxHeight: 48.adjustToScreenHeight)
            .background(.gray800)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray400)
                    .opacity(isDepartmentFocused ? 1 : 0)
            )
            .animation(.easeInOut(duration: 0.1), value: isDepartmentFocused)
        }
    }
}

#Preview {
    SignUpView(store: Store(initialState: SignUpFeature.State()) {
        SignUpFeature()
    })
}
