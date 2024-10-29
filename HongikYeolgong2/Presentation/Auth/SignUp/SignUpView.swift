//
//  SignInView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @Environment(\.injected.appState) var appState
    @Environment(\.injected.interactors.userDataInteractor) var userDataInetractor
    @Environment(\.presentationMode) var presentationMode
    
    @State private var signupData = SignupData()
    @State private var isSubmitButtonAvailable = false
    @State private var isCheckButtonAvailable = false
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        ZStack {
            Color.dark.edgesIgnoringSafeArea(.all)
            
            VStack {
                HeaderView(title: "회원가입")
                
                SignUpForm(signupData: $signupData)
                
                Spacer()
                
                SubmitButton(
                    isSubmitButtonAvailable: true,
                    action: {}
                )
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Labels
private struct HeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.suite(size: 18, weight: .bold))
            .foregroundStyle(.gray100)
            .frame(maxWidth: .infinity, minHeight: 52.adjustToScreenHeight, alignment: .leading)
    }
}

private struct TitleView: View {
    let title: String
    
    var body: some View {
        Text("닉네임")
            .font(.pretendard(size: 16, weight: .bold))
            .foregroundStyle(.gray200)
    }
}

private struct DescriptionView: View {
    let message: String
    let color: Color
    
    var body: some View {
        Text(message)
            .font(.pretendard(size: 12, weight: .regular))
            .foregroundStyle(color)
            .padding(.top, 4.adjustToScreenHeight)
    }
}

// MARK: - Form
private struct SignUpForm: View {
    @Binding var signupData: SignUpView.SignupData
    
    var body: some View {
        Group {
            VStack(alignment: .leading, spacing: 8) {
                TitleView(title: "닉네임")
                
                HStack {
                    HY2TextField(text: $signupData.nickname,
                                 placeholder: "닉네임을 입력해주세요",
                                 isError: signupData.nicknameStatus.isError)
                    
                    ActionButton(
                        title: "중복확인",
                        font: .pretendard(size: 16, weight: .regular),
                        height: 48.adjustToScreenHeight,
                        width: 88.adjustToScreenWidth,
                        backgroundColor: .blue100,
                        foregroundColor: .white,
                        action: {})
                    .cornerRadius(8)
                }
                
                DescriptionView(
                    message: signupData.nicknameStatus.message,
                    color: signupData.nicknameStatus.textColor
                )
            }
            
            VStack(alignment: .leading, spacing: 8) {
                TitleView(title: "학과")
                
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
        .padding(.top, 23.adjustToScreenHeight)
    }
}

// MARK: - Buttons
private struct SubmitButton: View {
    let isSubmitButtonAvailable: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
                   Image(isSubmitButtonAvailable ? .submitButtonEnable : .submitButtonDisable)
                       .resizable()
                       .frame(height: 50.adjustToScreenHeight)
               })
               .padding(.bottom, 20.adjustToScreenHeight)
    }
}

// MARK: - Helper Methods

private extension SignUpView {
    func requestCheckNickname() {
        userDataInetractor
            .checkUserNickname(nickname: signupData.nickname,
                               isValidate: $signupData.isNicknameAvailable)
    }
    
    func performSignUp() {
        userDataInetractor
            .signUp(nickname: signupData.nickname,
                    department: signupData.department)
    }
    
    func validateUserNickname(nickname: String) {
        if (!nickname.isEmpty && nickname.count < 2) || (!nickname.isEmpty && nickname.count > 8) {
            signupData.nicknameStatus = .notAllowedLength
        } else if nickname.contains(" ") {
            signupData.nicknameStatus = .specialCharactersAndSpaces
        } else if checkSpecialCharacter(nickname) {
            signupData.nicknameStatus = .specialCharactersAndSpaces
        } else if checkKoreanLang(nickname) {
            signupData.nicknameStatus = .none
        } else {
            signupData.nicknameStatus = .unknown
        }
    }
    
    func checkSpecialCharacter(_ input: String) -> Bool {
        let pattern: String = "[!\"#$%&'()*+,-./:;<=>?@[\\\\]^_`{|}~€£¥₩¢₹©®™§¶°•※≡∞≠≈‽✓✔✕✖←→↑↓↔↕↩↪↖↗↘↙ñ¡¿éèêëçäöüßàìòùåøæ]"
        
        if let _ = input.range(of: pattern, options: .regularExpression)  {
            return true
        } else {
            return false
        }
    }
    
    func checkKoreanLang(_ input: String) -> Bool {
        let pattern = "^[가-힣a-zA-Z\\s]*$"
        
        if let _ = input.range(of: pattern, options: .regularExpression)  {
            return true
        } else {
            return false
        }
    }
}

// MARK: - SignupData

extension SignUpView {
    struct SignupData {
        var nickname = ""
        var inputDepartment = ""
        var department: Department = .appliedArts
        var nicknameStatus: NicknameStatus = .none
        var isNicknameAvailable = false
    }
}

// MARK: - Nickname Status

extension SignUpView {
    enum NicknameStatus {
        case none // 기본상태
        case specialCharactersAndSpaces // 특수문자, 공백
        case notAllowedLength // 글자수 오류
        case available // 사용가능
        case alreadyUse // 사용중인 닉네임
        case unknown // 그외
        
        var message: String {
            switch self {
            case .none:
                "*한글, 영어, 숫자를 포함하여 2~8자를 입력해 주세요."
            case .specialCharactersAndSpaces:
                "*특수문자와 띄어쓰기를 사용할 수 없어요."
            case .notAllowedLength:
                "*한글, 영어, 숫자를 포함하여 2~8자를 입력해 주세요."
            case .available:
                "*닉네임을 사용할 수 있어요."
            case .alreadyUse:
                "*이미 사용중인 닉네임 입니다."
            case .unknown:
                "*올바른 형식의 닉네임이 아닙니다."
            }
        }
        
        var textColor: Color {
            switch self {
            case .none:
                    .gray400
            case .available:
                    .blue100
            default:
                    .yellow300
            }
        }
        
        var isError: Bool {
            switch self {
            case .none:
                false
            case .available:
                false
            default:
                true
            }
        }
    }
}
