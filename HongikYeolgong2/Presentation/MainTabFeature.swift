//
//  MainTabFeature.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/3/25.
//

import Foundation
import ComposableArchitecture

enum TabBar: CaseIterable {
    case home
    case record
    case ranking
    case setting
    
    var title: String {
        switch self {
        case .home:
            "홈"
        case .record:
            "기록"
        case .ranking:
            "랭킹"
        case .setting:
            "설정"
        }
    }
    var iconName: String {
         switch self {
         case .home: "home"
         case .record: "calendar"
         case .ranking: "ranking"
         case .setting: "setting"
         }
     }
     
     var iconNameSelected: String {
         switch self {
         case .home: "homeSelected"
         case .record: "calendarSelected"
         case .ranking: "rankingSelected"
         case .setting: "settingSelected"
         }
     }
}

@Reducer
struct MainTabFeature {
    @ObservableState
    struct State: Equatable {
        var currentTab: TabBar = .home
        var setting = SettingFeature.State()
        var record = RecordFeature.State()
    }
    
    enum Action: BindableAction {
        case changeTab(TabBar)
        case binding(BindingAction<State>)
        case setting(SettingFeature.Action)
        case record(RecordFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.setting, action: \.setting) {
            SettingFeature()
        }
        Scope(state: \.record, action: \.record) {
            RecordFeature()
        }
        BindingReducer()
        Reduce { state, action in
            switch action {
            case let .changeTab(tab):
                state.currentTab = tab
                return .none
            default:
                return .none
            }
        }
    }
}
