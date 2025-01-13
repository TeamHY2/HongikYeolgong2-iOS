//
//  NicknameFeature.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/6/25.
//

import Foundation
import ComposableArchitecture
import SwiftUI

@Reducer
struct NicknameFeature {
    @ObservableState
    struct State: Equatable {
        var nickname: String = ""
        var nicknameState: NicknameState = .none
    }
    
    enum Action {
        case inputNickname(String)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .inputNickname(let nickname):
                    state.nicknameState = checkNickname(nickname)
                    state.nickname = nickname
                    return .none
            }
        }
    }
    
    private func checkNickname(_ nickname: String) -> NicknameState {
        guard !nickname.isEmpty else { return .none }
        
        guard nickname.count >= 2 && nickname.count <= 8 else {
            return .invalidLength
        }
        
        let specialCharacters = CharacterSet(charactersIn: "-/:;()$&@\".,♥★?!'[]{}#%^*+=_\\|~<>€￡￥•.,♡☆?!'")
        guard !nickname.contains(" ") && nickname.rangeOfCharacter(from: specialCharacters) == nil else {
            return .specialCharactersAndSpaces
        }
        
        var validCharacterSet = CharacterSet.letters
        validCharacterSet.formUnion(CharacterSet(charactersIn: "가-힣"))
        guard nickname.unicodeScalars.allSatisfy({ validCharacterSet.contains($0) }) else {
            return .koreanAndEnglishOnly
        }
        
        return .validFormatPending
    }
}

enum NicknameState {
    case none // 입력 전, 글자수 벗어남
    case invalidLength // 글자수 벗어남
    case available // 중복 확인 후 사용 가능
    case validFormatPending // 중복 확인 전 사용 가능
    case alreadyExist // 닉네임 중복
    case specialCharactersAndSpaces // 특수문자 포함
    case koreanAndEnglishOnly // 한글, 영어 이외 입력한 경우
    
    var textColor: Color {
        switch self {
            case .none:  .gray400
            case .available, .validFormatPending: .blue100
            default: .yellow300
        }
    }
    
    var message: String {
        switch self {
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
            case .koreanAndEnglishOnly:
                "*한글, 영어만 사용할 수 있어요."
        }
    }
}
