//
//  SettingFeature.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/3/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SettingFeature {
    struct State: Equatable {
        
    }
    
    enum Action {
        case profileButtonTap
        case announcementButtonTap
        case inquiryButtonTap
        case toggleNotification
        case logoutButtonTap
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .profileButtonTap:
                    return .none
                case .announcementButtonTap:
                    return .none
                case .inquiryButtonTap:
                    return .none
                case .toggleNotification:
                    return .none
                case .logoutButtonTap:
                    return .none
            }
        }
    }
}
