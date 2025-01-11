//
//  SettingView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/11/25.
//

import SwiftUI
import ComposableArchitecture



struct SettingView: View {
    let store: StoreOf<SettingFeature>
    
    var body: some View {
        VStack(spacing: 0){
            // 프로필 부분
            profileView
            
            Spacer().frame(height: 24.adjustToScreenHeight)
            
            // 메뉴 버튼
            MenuItem
            
            Spacer()
            
            HStack(spacing: 24.adjustToScreenWidth){
                // 로그아웃 버튼
                Button{
                    store.send(.logoutButtonTap)
                } label: {
                    Text("로그아웃")
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(.gray300)
                }
                
                Text("|")
                    .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                    .foregroundStyle(.gray300)
                
                // 회원탈퇴 버튼
                Button{
                    store.send(.logoutButtonTap)
                } label: {
                    Text("회원탈퇴")
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(.gray300)
                }
            }
        }
        .padding(.top, 33.adjustToScreenHeight)
        .padding(.bottom, 36.adjustToScreenHeight)
        .padding(.horizontal, 32.adjustToScreenWidth)
    }
    
    /// 프로필 view
    var profileView: some View {
        VStack(spacing: 0){
            Image(.settingIcon)
                .resizable()
                .frame(width: 60.adjustToScreenWidth, height: 60.adjustToScreenHeight)
            
            Spacer().frame(height: 12.adjustToScreenHeight)

            // 프로필 수정 버튼
            Button {
                
            } label: {
                HStack(spacing: 0){
                    Text("닉네임")
                        .font(.pretendard(size: 18, weight: .bold), lineHeight: 22.adjustToScreenHeight)
                        .foregroundStyle(.gray100)
                    Image(.arrowRight)
                }
            }
            
            Spacer().frame(height: 3.adjustToScreenHeight)

            Text("학과")
                .font(.pretendard(size: 16, weight: .bold), lineHeight: 26.adjustToScreenHeight)
                .foregroundStyle(.gray100)
        }
    }
    
    /// Menu
    var MenuItem: some View {
        VStack(spacing: 0){
            // 공지사항 버튼
            MenuButton(title: "공지사항", action: {
                store.send(.announcementButtonTap)
            })
            
            Spacer().frame(height: 20.adjustToScreenHeight)
            
            // 문의사항 버튼
            MenuButton(title: "문의사항", action: {
                store.send(.announcementButtonTap)
            })
            
            Spacer().frame(height: 20.adjustToScreenHeight)
            
            // 알림 설정 버튼
            MenuButton(title: "열람실 종료 시간 알림", action: {
                store.send(.announcementButtonTap)
            }, type: .toggle, isOn: false)
            
            Spacer().frame(height: 10.adjustToScreenHeight)
            
            HStack(spacing: 5.adjustToScreenWidth) {
                Image(.icInformation)
                
                Text("열람실 종료 10분, 30분 전에 알림을 보내 연장을 돕습니다.")
                    .font(.pretendard(size: 12, weight: .regular),
                          lineHeight: 18.adjustToScreenHeight)
                    .foregroundStyle(.gray300)
                Spacer()
            }
        }
    }
}


