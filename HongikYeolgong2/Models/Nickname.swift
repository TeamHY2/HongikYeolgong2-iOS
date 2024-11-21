//
//  Nickname.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/29/24.
//

import SwiftUI

enum Nickname {
    case none, specialCharactersAndSpaces, notAllowedLength
    case available, alreadyUse, unknown, checkAvailable
    
    var message: String {
        switch self {
        case .none:
            "*한글, 영어를 포함하여 2~8자를 입력해 주세요."
        case .specialCharactersAndSpaces:
            "*특수문자와 띄어쓰기를 사용할 수 없어요."
        case .notAllowedLength:
            "*한글, 영어를 포함하여 2~8자를 입력해 주세요."
        case .available:
            "*닉네임을 사용할 수 있어요."
        case .checkAvailable:
            "*한글, 영어를 포함하여 2~8자를 입력해 주세요."
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
    
    var isCheckable: Bool {
        self == .available
    }
}
