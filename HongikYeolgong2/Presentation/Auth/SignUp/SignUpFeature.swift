//
//  SignUpFeature.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/5/25.
//

import Foundation
import ComposableArchitecture
import SwiftUICore

@Reducer
struct SignUpFeature {
    @ObservableState
    struct State {
        var nickname: String = ""
        var Department: String = ""
        var nicknameState: nicknameState = .none
        var message: String {
            switch nicknameState {
                case .none, .invalidLength:
                    "*한글, 영어를 포함하여 2~8자를 입력해 주세요."
                case .available:
                    "*닉네임을 사용할 수 있어요."
                case .validFormatPending:
                    "*사용 가능한 닉네입입니다. 중복확인 해주세요"
                case .alreadyExist:
                    "*이미 사용중인 닉네임 입니다."
                case .specialCharactersAndSpaces:
                    "*특수문자와 띄어쓰기를 사용할 수 없어요."
            }
        }
    }
    
    enum Action {
        case inputNickname(String)
        case inputDepartment(String)
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .inputNickname(let nickname):
                    state.nicknameState = checkNikcName(nickname)
                    state.nickname = nickname
                    return .none
                case .inputDepartment(let department):
                    state.Department = department
                    return .none
            }
        }
    }
    
    func checkNikcName(_ nickname: String) -> nicknameState {
        guard !nickname.isEmpty else { return .none }
        
        // 글자수 확인
        guard nickname.count >= 2 && nickname.count <= 8 else {
            return .invalidLength
        }
        // 특수문자 공백 확인
        let specialCharacters = CharacterSet(charactersIn: "-/:;()$&@\".,♥★?!'[]{}#%^*+=_\\|~<>€￡￥•.,♡☆?!'")
        guard !nickname.contains(" ") && nickname.rangeOfCharacter(from: specialCharacters) == nil else{
            return .specialCharactersAndSpaces
        }
        
        return .validFormatPending
        
    }
            
}

enum nicknameState {
    case none // 입력 전, 글자수 벗어남
    case invalidLength // 글자수 벗어남
    case available // 중복 확인 후 사용 가능
    case validFormatPending // 중복 확인 전 사용 가능
    case alreadyExist // 닉네임 중복
    case specialCharactersAndSpaces // 특수문자 포함
    
    var textColor: Color {
        switch self {
            case .none:  .gray400
            case .available, .validFormatPending: .blue100
            default: .yellow300
        }
    }
    
}
