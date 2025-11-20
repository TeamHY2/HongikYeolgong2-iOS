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
    case friend
    case record
    case ranking
    case setting
    
    var title: String {
        switch self {
            case .home: "홈"
            case .friend: "친구"
            case .record: "기록"
            case .ranking: "랭킹"
            case .setting: "설정"
        }
    }
    
    var iconName: String {
        switch self {
            case .home: "home"
            case .friend: "friends"
            case .record: "calendar"
            case .ranking: "ranking"
            case .setting: "setting"
        }
    }
    
    var iconNameSelected: String {
        switch self {
            case .home: "homeSelected"
            case .friend: "friendsSelected"
            case .record: "calendarSelected"
            case .ranking: "rankingSelected"
            case .setting: "settingSelected"
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter
    @State private var currentTab: Tab = .home
    
    var body: some View {
        TabView(selection: $router.currentTab,
                content:  {
            HomeView()
                .tag(Tab.home)
                .onAppear {
                    Amplitude.instance.track(eventType: "Home")
                }
            
            FriendsView()
                .tag(Tab.friend)
                .onAppear {
                    Amplitude.instance.track(eventType: "Friends")
                }
            
            
            RecordView()
                .tag(Tab.record)
                .onAppear {
                    Amplitude.instance.track(eventType: "Record")
                }
            
            RankingView()
                .tag(Tab.ranking)
                .onAppear {
                    Amplitude.instance.track(eventType: "Ranking")
                }
            
            SettingView()
                .tag(Tab.setting)
                .onAppear {
                    Amplitude.instance.track(eventType: "Setting")
                }
        })
        .overlay(alignment: .bottom) {
            TabBarView(currentTab: $router.currentTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct TabBarView: View {
    @Binding var currentTab: Tab
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                
                ForEach(Tab.allCases, id: \.hashValue) { tab in
                    VStack(spacing: 4.adjustToScreenHeight) {
                        Image(tab == currentTab ? tab.iconNameSelected : tab.iconName, bundle: nil)
                        
                        Text(tab.title)
                            .font(.pretendard(size: 10, weight: .medium))
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
    MainTabView().environmentObject(AppRouter())
}

