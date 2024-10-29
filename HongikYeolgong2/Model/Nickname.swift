//
//  Nickname.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/29/24.
//

import SwiftUI

enum NicknameStatus {
    case none, specialCharactersAndSpaces, notAllowedLength
    case available, alreadyUse, unknown, checkAvailable
    
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
        case .checkAvailable:
            "*한글, 영어, 숫자를 포함하여 2~8자를 입력해 주세요."
        case .alreadyUse:
            "*이미 사용중인 닉네임 입니다."
        case .unknown:
            "*올바른 형식의 닉네임이 아닙니다."
        }
    }
    
    var textColor: Color {
        switch self {
        case .none, .checkAvailable:  .gray400
        case .available: .blue100
        default: .yellow300
        }
    }
    
    var isError: Bool {
        switch self {
        case .none, .available, .checkAvailable:  false
        default: true
        }
    }
    
    static func validate(_ nickname: String) -> NicknameStatus {
        var status: NicknameStatus = .none
        status.validateUserNickname(nickname: nickname)
        return status
    }
    
    private enum Constant {
        static let minLength = 2
        static let maxLength = 8
    }
    
    mutating func validateUserNickname(nickname: String) {
        if nickname.isEmpty {
            self = .none
        } else if nickname.count < Constant.minLength || nickname.count > Constant.maxLength {
            self = .notAllowedLength
        } else if nickname.contains(" ") || checkSpecialCharacter(nickname) {
            self = .specialCharactersAndSpaces
        } else if checkKoreanLang(nickname) {
            self = .checkAvailable
        } else {
            self = .unknown
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
