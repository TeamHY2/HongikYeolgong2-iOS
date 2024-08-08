//
//  HomeView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showCompleteAlert = false
    @State private var showTimeExtensionAlert = false
    @State private var showingDialog = false
    
    @EnvironmentObject private var coordinator: AppCoordinator
    @EnvironmentObject private var timerViewModel: TimerViewModel
    @EnvironmentObject private var calendarViewModel: CalendarViewModel
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: timerViewModel.isStart ? UIScreen.UIHeight(11) : UIScreen.UIHeight(43))
            
            if timerViewModel.isStart {
                TimeLapse(startTime: timerViewModel.startTime,
                          endTime: timerViewModel.endTime,
                          timeRemaining: timerViewModel.remainingTime,
                          usageCount: calendarViewModel.todayStudyRoomUsageCount)
            } else {
                Quote()
            }
            
            Spacer()
                .frame(height: timerViewModel.isStart ? UIScreen.UIHeight(28) : UIScreen.UIHeight(120))
            
            if timerViewModel.isStart {
                if TimeInterval(timerViewModel.remainingTime) <= Constants.StudyRoomService.firstNotificationTime {
                    CustomButton(action: {
                        showTimeExtensionAlert = true
                    }, font: .suite, title: "열람실 이용 연장", titleColor: .white, backgroundColor: .customBlue100, leading: 0, trailing: 0)
                    
                    Spacer().frame(height: UIScreen.UIHeight(12))
                }
                
                CustomButton(action: {
                    showCompleteAlert = true
                }, font: .suite, title: "열람실 이용 종료", titleColor: .customGray100, backgroundColor: .customGray600, leading: 0, trailing: 0)
            } else {
                HStack {
                    CustomButton2(action: {}, title: "좌석", image: .angularButton01, maxWidth: 69, minHeight: 52)
                    
                    Spacer().frame(width: UIScreen.UIWidth(12))
                    
                    CustomButton2(action: {
                        showingDialog = true
                    }, title: "열람실 이용 시작", image: .angularButton02, maxWidth: .infinity, minHeight: 52)
                }
                
            }
            
            Spacer()
            
            CalendarView()
            
        }
        .background(
            Image(.iOSBackground)
                .ignoresSafeArea(.all)
                .allowsHitTesting(false)
        )
        .customNavigation(left: {
            CustomText(font: .suite, title: "홍익열공이", textColor: .customGray100, textWeight: .semibold, textSize: 18)
        }, right: {
            Button(action: {
                coordinator.push(.menu)
            }, label: {
                Image(.icHamburger)
            })
        })
        .dialog(isPresented: $showingDialog,
                currentDate: $timerViewModel.startTime) {
            timerViewModel.send(action: .startButtonTap)
        }
                .alert(title: "열람실을 다 이용하셨나요?",
                       confirmButtonText: "네",
                       cancleButtonText: "더 이용하기",
                       isPresented: $showCompleteAlert) {
                    saveData()
                }
                       .alert(title: "열람실 이용 시간을 연장할까요?",
                              confirmButtonText: "연장하기",
                              cancleButtonText: "아니오",
                              isPresented: $showTimeExtensionAlert) {
                           timerViewModel.send(action: .addTimeButtonTap)
                       }
                              .onReceive(timerViewModel.$remainingTime.filter { $0 <= 0 }) { _ in
                                  saveData()
                              }.onChange(of: scenePhase, perform: { value in
                                  guard timerViewModel.isStart == true else { return }
                                  
                                  if value == .active {
                                      timerViewModel.send(action: .enterFoureground)
                                  } else if value == .background {
                                      timerViewModel.send(action: .enterBackground)
                                  }
                              })
                              .onAppear {
                                  LocalNotificationService.shared.requestPermission()
                                  
                                  guard let email = authViewModel.user?.email else { return }
                                  calendarViewModel.send(action: .getCalendar(email))
                              }
    }
    
    func saveData() {
        // 타이머 중지
        timerViewModel.send(action: .completeButtonTap)
        
        // 총시간
        let totalTime = timerViewModel.totalTime
        let data = StudyRoomUsage(date: Date(), duration: totalTime)
        
        // 캘린더 업데이트
        calendarViewModel.send(action: .saveButtonTap(data, authViewModel.user?.email ?? ""))
    }
}


//#Preview {
//    HomeView()
//}
