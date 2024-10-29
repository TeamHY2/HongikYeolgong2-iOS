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
    let nicknameCheckSubject = CurrentValueSubject<Bool, Never>(false)
    
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
                        nickname: $userInfo.inputNickname,
                        nicknameStatus: $userInfo.nickname,
                        checkButtonTapped: checkUserNickname
                    )
                    
                    DepartmentFieldView(userInfo: $userInfo)
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
        .onChange(of: userInfo.inputNickname) {
            userInfo.nickname.validateUserNickname(nickname: $0)
        }
        .onReceive(nicknameCheckSubject.dropFirst()) {
            userInfo.nickname = $0 ? .alreadyUse : .available
        }
        .onChange(of: userInfo) {
            isSubmitButtonEnable = $0.nickname == .available &&
                                  userInfo.department != .none
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
                .frame(
                    maxWidth: .infinity,
                    minHeight: 52.adjustToScreenHeight,
                    alignment: .leading
                )
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
        @Binding var nicknameStatus: Nickname
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
                        nicknameStatus: nicknameStatus,
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
    
    // MARK: - Select Departments
    struct DepartmentFieldView: View {
        @Binding var userInfo: UserInfo
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                TitleView(title: "학과")
                
                DropDownPicker(
                    text: $userInfo.inputDepartment,
                    seletedItem: Binding(
                        get: { userInfo.department.rawValue },
                        set: { userInfo.department = .init(rawValue: $0) ?? .none }
                    ),
                    placeholder: "학과를 입력해주세요",
                    items: Department.allCases.filter { $0 != .none }
                                                   .map { $0.rawValue }
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
        let nicknameStatus: Nickname
        let action: () -> Void
        
        var body: some View {
            ActionButton(
                title: "중복확인",
                font: .pretendard(size: 16, weight: .regular),
                height: 48.adjustToScreenHeight,
                width: 88.adjustToScreenWidth,
                backgroundColor: nicknameStatus == .available ? .blue400 : .blue100,
                foregroundColor: .white,
                action: action
            )
            .cornerRadius(8)
            .disabled(!(nicknameStatus == .checkAvailable))
        }
    }
}

// MARK: - Helper Methods
private extension SignUpView {
    func checkUserNickname() {
        userDataInteractor.checkUserNickname(
            nickname: userInfo.inputNickname,
            nicknameCheckSubject: nicknameCheckSubject
        )
    }
    
    func performSignUp() {
        userDataInteractor.signUp(
            nickname: userInfo.inputNickname,
            department: userInfo.department
        )
    }
}
