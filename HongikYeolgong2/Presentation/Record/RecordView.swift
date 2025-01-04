//
//  RecordView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/3/25.
//

import SwiftUI
import ComposableArchitecture

struct RecordView: View {
    let store: StoreOf<RecordFeature>
    
    var body: some View {
        VStack(spacing: 13.adjustToScreenHeight) {
            calendar
            Spacer()
            record
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .padding(.top, 32.adjustToScreenHeight)
        .padding(.bottom, 36.adjustToScreenHeight)
        .modifier(IOSBackground())
    }
    
    var calendar: some View {
        VStack {
            // Header
            HStack {
                Text(store.selectedDate.getMonthString())
                    .font(.suite(size: 24, weight: .bold))
                
                Text(store.selectedDate.getYearString())
                    .font(.suite(size: 24, weight: .bold))
                
                Spacer()
                
                HStack {
                    Button {
                        store.send(.changeMonth(.prev))
                    } label: {
                        Image(.icCalendarLeft)
                    }
                    
                    Button {
                        store.send(.changeMonth(.next))
                    } label: {
                        Image(.icCalendarRight)
                    }
                }
            }
            .padding()
            
            // Weekdays
            HStack {
                ForEach(WeekDayEng.allCases, id: \.self) { day in
                    Text(day.rawValue)
                        .font(.suite(size: 12, weight: .medium))
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Days Grid
            LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 5), count: 7), spacing: 5) {
                ForEach(store.currentMonth, id: \.id) { day in
                    CalendarCell(dayInfo: day)
                }
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
    
    /// 하단 기록 뷰
    var record: some View {
        VStack(spacing: 13.adjustToScreenHeight) {
            ForEach(0..<store.records.count / 2, id: \.self) { index in
                HStack(spacing: 13.adjustToScreenWidth) {
                    RecordCell(record: store.records[index * 2])
                    RecordCell(record: store.records[index * 2 + 1])
                }
            }
        }
    }
}


#Preview {
    RecordView(store: Store(initialState: RecordFeature.State()) {
        RecordFeature()
    })
}
