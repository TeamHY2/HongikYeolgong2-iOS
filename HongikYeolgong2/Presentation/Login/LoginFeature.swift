//
//  LoginFeature.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/11/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct LoginFeature {
    struct State: Equatable {
        
    }
    
    enum Action {
        case loginButtonTap
    }
    var body: some ReducerOf<Self> {
      
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
