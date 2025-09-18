//
//  FocusModeView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 6/16/25.
//

import SwiftUI
import Combine

struct FocusModeView: View {
    @Binding var studySession: AppState.StudySession
    @Binding var studyStatusInfos: Loadable<[StudyStatusInfo]>
    @Binding var isPresented: Bool
    
    // action
    let retryAction: () -> Void
    let addTiem: () -> Void
    let endStudy: () -> Void
    
    @State var isShowAddTimeModal: Bool = false
    @State var isShowEndUseModal: Bool = false
    
    // 30초마다
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    
    // 현재 사용중인 사용자 수
    var countOfActiveStudents: Int {
        if let studyInfos = studyStatusInfos.value {
            return studyInfos.filter { $0.studyStatus }.count
        }
        return 0
    }
    
    
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
        .onReceive(timer) { _ in
            retryAction()
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            HStack {
                Text("포커스모드")
                    .font(.suite(size: 18, weight: .semibold))
                    .foregroundStyle(.gray100)
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
                StudyPeriodView(
                    startTime: studySession.firstStartTime,
                    endTime: studySession.endTime
                )
                StudyTimerView(
                    totalTime: studySession.totalTime,
                    remainingTime: studySession.remainingTime,
                    color: studySession.isAddTime ? .yellow100 : .white
                )
                
                HStack(spacing: 12.adjustToScreenWidth) {
                    BaseButton(
                        title: "열람실 이용 종료",
                        backgroundColor: .gray600,
                        radius: 4,
                        action: {
                            isShowEndUseModal.toggle()
                        }
                    )
                    
                    if studySession.isAddTime {
                        BaseButton(
                            title: "열람실 이용 연장",
                            backgroundColor: .blue100,
                            radius: 4,
                            action: {
                                isShowAddTimeModal.toggle()
                            }
                        )
                    } else {
                        Spacer()
                            .frame(maxWidth: .infinity)
                    }
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
                    Text("\(countOfActiveStudents)명")
                        .font(.pretendard(size: 14, weight: .regular), lineHeight: 20.adjustToScreenHeight)
                        .foregroundStyle(.blue50)
                    Text("공부중")
                        .font(.pretendard(size: 14, weight: .regular), lineHeight: 20.adjustToScreenHeight)
                        .foregroundStyle(.gray300)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
           
            .padding(.top, 36)
            .padding(.bottom, 20)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 12) {
                    if let info = studyStatusInfos.value {
                        ForEach(info, id: \.self) { studyStatusInfo in
                            FocusCell(studyStatusInfo: studyStatusInfo)
                        }
                    }
                }
            }
        }
        .systemOverlay(isPresented: $isShowAddTimeModal) {
            ModalView(
                isPresented: $isShowAddTimeModal,
                title: "열람실 이용 시간을 연장할까요?",
                confirmButtonText: "연장하기",
                cancleButtonText: "아니오",
                confirmAction: {
                    addTiem() }
            )
        }
        .systemOverlay(isPresented: $isShowEndUseModal) {
            ModalView(
                isPresented: $isShowEndUseModal,
                title: "열람실을 다 이용하셨나요?",
                confirmButtonText: "네",
                cancleButtonText: "더 이용하기",
                confirmAction: {
                    endStudy()
                    isPresented.toggle()
                })
        }
        .padding(.horizontal, 32)
        .modifier(IOSBackground())
    }
}
