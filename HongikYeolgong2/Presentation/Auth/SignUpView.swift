//
//  SignInView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @Environment(\.injected.interactors.userDataInteractor) var userDataInetractor
    
    @State private var signupData = SignupData()
    @State private var isSubmitButtonAvailable = false
    @State private var isCheckButtonAvailable = false
    
    var body: some View {
        content
            .onChange(of: signupData.nickname, perform: { validateUserNickname(nickname: $0)} )
            .onChange(of: signupData.nicknameStatus, perform: { isCheckButtonAvailable = $0 == .none })
            .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Main Content

private extension SignUpView {
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

private extension SignUpView {
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
                             isError: signupData.nicknameStatus.isError)
                
                duplicateCheckButton
            }
            
            Text(signupData.nicknameStatus.message)
                .font(.pretendard(size: 12, weight: .regular))
                .foregroundStyle(signupData.nicknameStatus.textColor)
                .padding(.top, 4.adjustToScreenHeight)
        }
    }
    
    var duplicateCheckButton: some View {
        Button(action: requestCheckNickname) {
            Text("중복확인")
                .font(.pretendard(size: 16, weight: .regular))
                .frame(maxWidth: .infinity, maxHeight: 48.adjustToScreenHeight)
                .foregroundColor(.white)
        }
        .frame(width: 88.adjustToScreenWidth)
        .background(isCheckButtonAvailable ? .blue100 : .blue400)
        .disabled(!isCheckButtonAvailable)
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
        Button(action: performSignUp, label: {
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

private extension SignUpView {
    struct SignupData {
        var nickname = ""
        var inputDepartment = ""
        var department: Department = .appliedArts
        var nicknameStatus: NicknameStatus = .none
        var isNicknameAvailable = false
    }
}

// MARK: - Nickname Status

private extension SignUpView {
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
