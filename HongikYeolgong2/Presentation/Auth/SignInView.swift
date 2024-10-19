//
//  SignInView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI
import Combine

struct SignInView: View {
    @Environment(\.injected) var injected: DIContainer
    @State private var signupData = SignupData()
    @State private var isSubmitButtonAvailable = false
    
    var body: some View {
        content
            .onChange(of: signupData.nickname) { _ in isSubmitButtonAvailable = false }
            .onChange(of: signupData.isNicknameAvailable) { isSubmitButtonAvailable = $0 }
            .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Main Content

private extension SignInView {
    var content: some View {
        ZStack {
            Color.dark.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                titleView
                signupForm
                Spacer()
                submitButton
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
        }
    }
}

// MARK: - Subviews

private extension SignInView {
    var titleView: some View {
        Text("회원가입")
            .font(.suite(size: 18, weight: .bold))
            .foregroundStyle(.gray100)
            .frame(maxWidth: .infinity, minHeight: 52.adjustToScreenHeight, alignment: .leading)
    }
    
    var signupForm: some View {
        VStack(spacing: 0) {
            nicknameField
            selecteDepartment
        }
        .padding(.top, 23.adjustToScreenHeight)
    }
    
    var nicknameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("닉네임")
                .font(.pretendard(size: 16, weight: .bold))
                .foregroundStyle(.gray200)
            
            HStack {
                HY2TextField(text: $signupData.nickname,
                             placeholder: "닉네임을 입력해주세요",
                             isError: false)
                
                duplicateCheckButton
            }
            
            Text("* 한글, 영어, 숫자를 포함하여 2~8자를 입력해 주세요.")
                .font(.pretendard(size: 12, weight: .regular))
                .foregroundStyle(.gray400)
                .padding(.top, 4.adjustToScreenHeight)
        }
    }
    
    var duplicateCheckButton: some View {
        Button(action: checkUserNickname) {
            Text("중복확인")
                .font(.pretendard(size: 16, weight: .regular))
                .frame(maxWidth: .infinity, maxHeight: 48.adjustToScreenHeight)
                .foregroundColor(.white)
        }
        .frame(width: 88.adjustToScreenWidth)
        .background(.blue100)
        .cornerRadius(8)
    }
    
    var selecteDepartment: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("학과")
                .font(.pretendard(size: 16, weight: .bold))
                .foregroundStyle(.gray200)
            
            DropDownPicker(text: $signupData.inputDepartment,
                           seletedItem: Binding(
                            get: { signupData.department.rawValue },
                            set: { signupData.department = .init(rawValue: $0) ?? .appliedArts }
                           ),
                           placeholder: "학과를 입력해주세요",
                           items: Department.allCases.map { $0.rawValue })
        }
        .padding(.top, 12.adjustToScreenHeight)
    }
    
    var submitButton: some View {
        HY2Button(title: "",
                  style: .imageButton(image: isSubmitButtonAvailable ? .submitButtonEnable : .submitButtonDisable)) {
            // Submit action
        }
        .padding(.bottom, 20.adjustToScreenHeight)
    }
}

// MARK: - Helper Methods

private extension SignInView {
    func checkUserNickname() {
        injected.interactors.userDataInteractor.checkUserNickname(
            nickname: signupData.nickname,
            isValidate: $signupData.isNicknameAvailable
        )
    }
}

// MARK: - SignupData

private extension SignInView {
    struct SignupData {
        var nickname = ""
        var inputDepartment = ""
        var department: Department = .appliedArts
        var isNicknameAvailable = false
    }
}
