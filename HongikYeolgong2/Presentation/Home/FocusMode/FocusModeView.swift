//
//  FocusModeView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 6/16/25.
//

import SwiftUI

struct FocusModeView: View {
    @Binding var studyStatusInfos: Loadable<[StudyStatusInfo]>
    @Binding var isPresented: Bool
    let retryAction: () -> Void
    
    
    let items = Array(1...69)
    let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 4)
    
    var body: some View {
        NetworkStateView(
            loadables: [
                AnyLoadable($studyStatusInfos)
            ],
            retryAction: retryAction
        ) {
            content
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                // 닫기 버튼
                Button {
                    isPresented.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15.adjustToScreenWidth, height: 15.adjustToScreenHeight)
                        .foregroundStyle(.gray100)
                }
                .padding(.vertical, 14.adjustToScreenHeight)
            }
            
            VStack(spacing: 0) {
                StudyPeriodView(startTime: .now, endTime: .now)
                StudyTimerView(totalTime: .seconds(0), remainingTime: .seconds(0), color: .white)
                
                HStack(spacing: 12.adjustToScreenWidth) {
                    BaseButton(
                        title: "열람실 이용 연장",
                        backgroundColor: .blue100,
                        radius: 4,
                        action: {}
                    )
                    BaseButton(
                        title: "열람실 이용 종료",
                        backgroundColor: .gray600,
                        radius: 4,
                        action: {  }
                    )
                }
                .padding(.top, 28)
            }
            .padding(.top, 12)
            VStack(spacing: 4) {
                Text("전체")                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.suite(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                    .foregroundStyle(.gray100)
                HStack {
                    Text("12명")
                        .font(.suite(size: 14, weight: .regular), lineHeight: 20.adjustToScreenHeight)
                        .foregroundStyle(.blue100)
                    Text("공부중")
                        .font(.suite(size: 14, weight: .regular), lineHeight: 20.adjustToScreenHeight)
                        .foregroundStyle(.gray300)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
           
            .padding(.top, 36)
            .padding(.bottom, 20)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                   
                    ForEach(items, id: \.self) { item in
                        FocusCell()
                    }
                }
            }
        }
        .padding(.horizontal, 32)
        .modifier(IOSBackground())
    }
}
