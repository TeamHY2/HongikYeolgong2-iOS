//
//  MainTabFeature.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/3/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct MainTabFeature {
    
    struct State: Equatable {}
    
    enum Action {
        case homeTab
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
