//
//  MainTabView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/3/25.
//

import SwiftUI
import ComposableArchitecture
struct MainTabView: View {
    @Perception.Bindable var store: StoreOf<MainTabFeature>
    var body: some View {
        WithPerceptionTracking {
            TabView(selection: $store.currentTab) {
                HomeView()
                    .tag(TabBar.home)
                RecordView()
                    .tag(TabBar.record)
                RankingView()
                    .tag(TabBar.ranking)
                SettingView(store: store.scope(state: \.setting, action: \.setting))
                    .tag(TabBar.setting)
            }.overlay(alignment: .bottom) {
                makeTabView()
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    func makeTabView() -> some View {
        return VStack {
            HStack {
                Spacer()
                ForEach(TabBar.allCases, id: \.hashValue) { tab in
                    
                    VStack {
                        let tabSelected = tab == store.currentTab
                        Image(tabSelected ? tab.iconNameSelected : tab.iconName, bundle: nil)
                            .padding(.top, 12)
                        
                        Text("\(tab.title)")
                            .font(.pretendard(size: 12, weight: .regular))
                            .frame(height: 18)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        store.send(.changeTab(tab))
                    }
                   
                    Spacer()
                }
                
            }
        }
        .frame(height: 88)
        .background(Image(.tabview)
            .resizable()
            .frame(maxWidth: .infinity))
    }
}

