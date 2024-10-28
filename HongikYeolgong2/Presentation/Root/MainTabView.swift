//
//  MainTabView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

enum Tab: CaseIterable {
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
        case .home:
            "home"
        case .record:
            "calendar"
        case .ranking:
            "ranking"
        case .setting:
            "setting"
        }
    }
    
    var iconNameSelected: String {
        switch self {
        case .home:
            "homeSelected"
        case .record:
            "calendarSelected"
        case .ranking:
            "rankingSelected"
        case .setting:
            "settingSelected"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.dark.ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer()
                switch selectedTab {
                case .home:
                    HomeView()                    
                case .record:
                    RecordView()
                case .ranking:
                    RankingView()
                case .setting:
                    SettingView()
                }
                Spacer()
            }
            .padding(.bottom, SafeAreaHelper.getTabBarHeight())
            
            TabBarView(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)        
    }
}

struct TabBarView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Spacer()
                
                ForEach(Tab.allCases, id: \.hashValue) { tab in
                    VStack(spacing: 5.adjustToScreenHeight) {
                        Image(tab == selectedTab ? tab.iconNameSelected : tab.iconName, bundle: nil)
                        
                        Text(tab.title)
                            .font(.pretendard(size: 12, weight: .regular))
                            .foregroundStyle(tab == selectedTab ? .gray100 : .gray300)
                            .frame(height: 18.adjustToScreenHeight)
                    }
                    .frame(maxWidth: .infinity)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedTab = tab
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
