//
//  SignInView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI
import Combine

// MARK: - SignUpView
struct SignUpView: View {
    // MARK: - Environment
    @Environment(\.injected.appState) var appState
    @Environment(\.injected.interactors.userDataInteractor) var userDataInteractor
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - State
    @State private var userInfo = UserInfo()
    @State private var isSubmitButtonEnable = false
    @State private var isCheckButtonEnable = false
    @State private var isNicknameAvailable = false
    
    // MARK: - Initialization
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.dark.edgesIgnoringSafeArea(.all)
            
            VStack {
                HeaderView(title: "회원가입")
                
                VStack(spacing: 12) {
                    NicknameFieldView(
                        nickname: $userInfo.nickname,
                        nicknameStatus: $userInfo.nicknameStatus,
                        checkButtonTapped: checkNicknameAvailability
                    )
                    
                    DepartmentFieldView(signUpInfo: $userInfo)
                }
                
                Spacer()
                
                SubmitButton(
                    isSubmitButtonEnable: isSubmitButtonEnable,
                    submitButtonTapped: performSignUp
                )
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onChange(of: userInfo.nickname) {
            userInfo.nicknameStatus.validateUserNickname(nickname: $0)
        }
    }
}

// MARK: - Components
private extension SignUpView {
    // MARK: - Header
    struct HeaderView: View {
        let title: String
        
        var body: some View {
            Text(title)
                .font(.suite(size: 18, weight: .bold))
                .foregroundStyle(.gray100)
                .frame(maxWidth: .infinity,
                       minHeight: 52.adjustToScreenHeight,
                       alignment: .leading)
        }
    }
    
    // MARK: - Title
    struct TitleView: View {
        let title: String
        
        var body: some View {
            Text(title)
                .font(.pretendard(size: 16, weight: .bold))
                .foregroundStyle(.gray200)
        }
    }
    
    // MARK: - Description
    struct DescriptionView: View {
        let message: String
        let color: Color
        
        var body: some View {
            Text(message)
                .font(.pretendard(size: 12, weight: .regular))
                .foregroundStyle(color)
                .padding(.top, 4.adjustToScreenHeight)
        }
    }
    
    
    // MARK: - Nickname Field
    struct NicknameFieldView: View {
        @Binding var nickname: String
        @Binding var nicknameStatus: NicknameStatus
        let checkButtonTapped: () -> Void
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                TitleView(title: "닉네임")
                
                HStack {
                    HY2TextField(
                        text: $nickname,
                        placeholder: "닉네임을 입력해주세요",
                        isError: nicknameStatus.isError
                    )
                    
                    DuplicateCheckButton(
                        checkButtonEnabled: nicknameStatus == .checkAvailable,
                        action: checkButtonTapped
                    )
                }
                
                DescriptionView(
                    message: nicknameStatus.message,
                    color: nicknameStatus.textColor
                )
            }
        }
    }
    
    // MARK: - Selecte Departments
    struct DepartmentFieldView: View {
        @Binding var signUpInfo: UserInfo
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                TitleView(title: "학과")
                
                DropDownPicker(
                    text: $signUpInfo.inputDepartment,
                    seletedItem: Binding(
                        get: { signUpInfo.department.rawValue },
                        set: { signUpInfo.department = .init(rawValue: $0) ?? .appliedArts }
                    ),
                    placeholder: "학과를 입력해주세요",
                    items: Department.allCases.map { $0.rawValue }
                )
            }
        }
    }
    
    // MARK: - Buttons
    struct SubmitButton: View {
        let isSubmitButtonEnable: Bool
        let submitButtonTapped: () -> Void
        
        var body: some View {
            Button(action: submitButtonTapped) {
                Image(isSubmitButtonEnable ? .submitButtonEnable : .submitButtonDisable)
                    .resizable()
                    .frame(height: 50.adjustToScreenHeight)
            }
            .padding(.bottom, 20.adjustToScreenHeight)
            .disabled(!isSubmitButtonEnable)
        }
    }
    
    struct DuplicateCheckButton: View {
        let checkButtonEnabled: Bool
        let action: () -> ()
        var body: some View {
            ActionButton(
                title: "중복확인",
                font: .pretendard(size: 16, weight: .regular),
                height: 48.adjustToScreenHeight,
                width: 88.adjustToScreenWidth,
                backgroundColor: .blue100,
                foregroundColor: .white,
                action: action
            )
            .cornerRadius(8)
            .disabled(!checkButtonEnabled)
        }
    }
}

// MARK: - Helper Methods
private extension SignUpView {
    func checkNicknameAvailability() {
        userDataInteractor.checkUserNickname(
            nickname: userInfo.nickname,
            isValidate: $isNicknameAvailable
        )
    }
    
    func performSignUp() {
        userDataInteractor.signUp(
            nickname: userInfo.nickname,
            department: userInfo.department
        )
    }
}

