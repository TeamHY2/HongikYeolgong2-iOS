//
//  Calendar.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/12/24.
//

import SwiftUI
import Combine

enum WeekDay: String, CaseIterable {
    case sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Wed = "Wed"
    case Thu = "Thu"
    case Fri = "Fri"
    case Sat = "Sat"
}

struct CalendarView: View {
    
    @EnvironmentObject private var viewModel: CalendarViewModel
    
    private let columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            // header
            HStack(spacing: 0) {
                CustomText(font: .suite, 
                           title: viewModel.seletedDate.getMonthString(),
                           textColor: .customGray100,
                           textWeight: .bold,
                           textSize: 24)
                
                Spacer().frame(width: UIScreen.UIWidth(8))
                
                CustomText(font: .suite, 
                           title: viewModel.seletedDate.getYearString(), 
                           textColor: .customGray100,
                           textWeight: .bold,
                           textSize: 24)
                
                Spacer()
                HStack {
                    Button(action: {
                        viewModel.send(action: .moveButtonTap(.prev))
                    }) {
                        Image(.icCalendarLeft)
                    }
                    
                    Spacer().frame(width: UIScreen.UIWidth(7))
                    
                    Button(action: {
                        viewModel.send(action: .moveButtonTap(.next))
                    }) {
                        Image(.icCalendarRight)
                    }
                }
            }
            
            Spacer().frame(height: UIScreen.UIHeight(12))
            
            // weakday
            HStack(alignment: .center) {
                ForEach(WeekDay.allCases, id: \.rawValue) {
                    CustomText(font: .suite, 
                               title: $0.rawValue,
                               textColor: .customGray300,
                               textWeight: .medium,
                               textSize: 12)
                        .frame(maxWidth: .infinity)
                }
            }
            
            Spacer().frame(height: UIScreen.UIHeight(8))
            // seleteMonth가 변경될때마다 makeMonth의 값을 받아서 currentMonth에 업데이트
            // grid
            LazyVGrid(columns: columns, spacing: UIScreen.UIWidth(5)) {
                ForEach(viewModel.currentMonth, id: \.id) {
                    CalendarCell(dayInfo: $0)
                }
            }
        }
    }
}

#Preview {
    CalendarView()
}
