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
    struct State: Equatable {
        var nicknameFeatureState = NicknameFeature.State()
        var departmentFeatureState = DepartmentFeature.State()
        var isSignUpButtonEnabled: Bool {
            return nicknameFeatureState.nicknameState != .available || departmentFeatureState.selectedDepartment == .none
        }
    }
    
    enum Action {
        case nicknameFeatureAction(NicknameFeature.Action)
        case departmentFeatureAction(DepartmentFeature.Action)
        case signUpButtonTap
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.nicknameFeatureState, action: \.nicknameFeatureAction) {
            NicknameFeature()
        }
        Scope(state: \.departmentFeatureState, action: \.departmentFeatureAction) {
            DepartmentFeature()
        }
        Reduce { state, action in
            switch action {
                    
                case .nicknameFeatureAction, .departmentFeatureAction:
                    return .none
                    
                case .signUpButtonTap:
                    // 회원가입 로직 처리
                    return .none
            }
        }
    }
}



