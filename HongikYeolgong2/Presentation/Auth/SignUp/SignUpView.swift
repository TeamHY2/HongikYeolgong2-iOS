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
    @State private var keyboardOffset: CGFloat = 23
    let nicknameCheckSubject = CurrentValueSubject<Bool, Never>(false)
    
    // MARK: - Initialization
    init() {
//        UINavigationBar.setAnimationsEnabled(false)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.dark.edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationHeaderView(title: "회원가입")
                
                VStack(spacing: 12.adjustToScreenWidth) {
                    VStack(alignment: .leading, spacing: 8.adjustToScreenHeight) {
                        TitleView(title: "닉네임")
                        
                        HStack {
                            HY2TextField(
                                text: $userInfo.inputNickname,
                                placeholder: "닉네임을 입력해주세요",
                                isError: userInfo.nickname.isError
                            )
                            
                            DuplicateCheckButton(
                                nicknameStatus: userInfo.nickname,
                                action: checkUserNickname
                            )
                        }
                        
                        DescriptionView(
                            message: userInfo.nickname.message,
                            color: userInfo.nickname.textColor
                        )
                    }
                    
                    VStack(alignment: .leading, spacing: 8.adjustToScreenHeight) {
                        TitleView(title: "학과")
                        
                        DropDownPicker(
                            text: $userInfo.inputDepartment,
                            seletedItem: Binding(
                                get: { userInfo.department.rawValue },
                                set: { userInfo.department = .init(rawValue: $0) ?? .none }
                            ),
                            placeholder: "학과를 입력해주세요",
                            items: Department.allDepartments()
                        )
                    }
                }
                .offset(y: keyboardOffset)
                .animation(.easeIn(duration: 0.2), value: keyboardOffset)
                
                Spacer()
                
                SubmitButton(
                    isSubmitButtonEnable: isSubmitButtonEnable,
                    submitButtonTapped: performSignUp
                )
            }
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
        }
        .toolbar(.hidden, for: .navigationBar)
       
        .onChange(of: userInfo.inputNickname) { inputNickname in
            userInfo.nickname.validateUserNickname(nickname: inputNickname)
        }
        .onChange(of: userInfo) { userInfo in
            isSubmitButtonEnable = userInfo.nickname == .available &&
            userInfo.department != .none
        }
        .onReceive(nicknameCheckSubject.dropFirst()) { isAlreadyInUse in
            userInfo.nickname = isAlreadyInUse ? .alreadyUse : .available
        }
        .onReceive(keyboardVisibilityUpdated) { isKeyboardVisibility in
            if isKeyboardVisibility {
                keyboardOffset = 0
            } else {
                keyboardOffset = 23
            }
        }
    }
}

// MARK: - Components
private extension SignUpView {
    // MARK: - Header
    struct NavigationHeaderView: View {
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
                .font(.pretendard(size: 16, weight: .bold), lineHeight: 26)
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

// MARK: - Interactor
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
    
    var keyboardVisibilityUpdated: AnyPublisher<Bool, Never> {
        appState.updates(for: \.system.isKeyboardActive)
    }
}
