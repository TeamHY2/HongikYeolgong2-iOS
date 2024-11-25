//
//  MainTabView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI
import AmplitudeSwift

enum Tab: CaseIterable {
    case home
    case record
    case ranking
    case setting
    
    var title: String {
        switch self {
        case .home: "홈"
        case .record: "기록"
        case .ranking: "랭킹"
        case .setting: "설정"
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

struct MainTabView: View {
    @State private var currentTab: Tab = .home
    
    var body: some View {
        NavigationStack {
            TabView(selection: $currentTab,
                    content:  {
                HomeView()
                    .tag(Tab.home) 
                    .onAppear {
                        print("\(SecretKeys.ampliKey)")
                        Amplitude.instance.track(eventType: "Enter home screen")
                    }
                
                RecordView()
                    .tag(Tab.record)
                    .onAppear {
                        Amplitude.instance.track(eventType: "Enter record screen")
                    }
                
                RankingView()
                    .tag(Tab.ranking)
                    .onAppear {
                        Amplitude.instance.track(eventType: "Enter ranking screen")
                    }
                
                SettingView()
                    .tag(Tab.setting)
                    .onAppear {
                        Amplitude.instance.track(eventType: "Enter setting screen")
                    }
            })
            .overlay(alignment: .bottom) {
                TabBarView(currentTab: $currentTab)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

struct TabBarView: View {
    @Binding var currentTab: Tab
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                
                ForEach(Tab.allCases, id: \.hashValue) { tab in
                    VStack(spacing: 5.adjustToScreenHeight) {
                        Image(tab == currentTab ? tab.iconNameSelected : tab.iconName, bundle: nil)
                        
                        Text(tab.title)
                            .font(.pretendard(size: 12, weight: .regular))
                            .foregroundStyle(tab == currentTab ? .gray100 : .gray300)
                            .frame(height: 18.adjustToScreenHeight)
                    }
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        currentTab = tab
                    }
                    
                    Spacer()
                }
            }
            .padding(.top, 12.adjustToScreenHeight)
            .padding(.horizontal, 20.adjustToScreenWidth)
            Spacer()
        }
        .frame(height: SafeAreaHelper.getTabBarHeight())
        .background(Image(.tabview)
            .resizable()
            .frame(maxWidth: .infinity))
    }
}

#Preview {
    MainTabView()
}

