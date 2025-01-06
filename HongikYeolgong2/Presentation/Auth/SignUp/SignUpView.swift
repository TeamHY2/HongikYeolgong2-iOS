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

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 0) {
                Text("회원가입")
                    .font(.suite(size: 18, weight: .bold))
                    .foregroundStyle(.gray100)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: 52.adjustToScreenHeight,
                        alignment: .leading
                    )
                
                Spacer().frame(height: 23.adjustToScreenHeight)
                
                Text("닉네임")
                    .font(.pretendard(size: 16, weight: .bold), lineHeight: 26)
                    .foregroundStyle(.gray200)
                
                Spacer().frame(height: 8.adjustToScreenHeight)
                
                // 닉네임 입력창
                NicknameInputView(
                    nickname: viewStore.binding(
                        get: \.nicknameFeatureState.nickname,
                        send: { SignUpFeature.Action.nicknameFeatureAction(.inputNickname($0)) }
                    ),
                    nicknameState: viewStore.nicknameFeatureState.nicknameState
                )
                
                Spacer().frame(height: 4.adjustToScreenHeight)
                
                // 닉네임 안내 메세지
                Text(viewStore.nicknameFeatureState.nicknameState.message)
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundStyle(viewStore.nicknameFeatureState.nicknameState.textColor)
                
                Spacer().frame(height: 12.adjustToScreenHeight)
                
                Text("학과")
                    .font(.pretendard(size: 16, weight: .bold), lineHeight: 26)
                    .foregroundStyle(.gray200)
                
                Spacer().frame(height: 8.adjustToScreenHeight)
                
                // 학과 입력창, 학과 리스트
                DepartmentInputView(
                    searchDepartment: viewStore.binding(
                        get: \.departmentFeatureState.searchDepartment,
                        send: {SignUpFeature.Action.departmentFeatureAction(.inputDepartment($0))}
                    ),
                    departments: viewStore.departmentFeatureState.departments,
                    selectedDepartment: { department in
                        viewStore.send(.departmentFeatureAction(.selectDepartment(department)))
                    }
                )
                
                Spacer()
                
                // 회원가입 버튼
                Button {
                    viewStore.send(.signUpButtonTap)
                } label: {
                    Image(.submitButtonEnable)
                        .resizable()
                        .frame(height: 50.adjustToScreenHeight)
                }
                .padding(.bottom, 12)
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
        }
    }
}


#Preview {
    SignUpView(store: Store(initialState: SignUpFeature.State()) {
        SignUpFeature()
    })
}
