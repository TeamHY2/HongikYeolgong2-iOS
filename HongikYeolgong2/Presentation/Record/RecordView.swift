//
//  RecordView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/3/25.
//

import SwiftUI

struct RecordView: View {
    
    private var records: [(title: String, hours: Int, minutes: Int)] {
        [
            ("연간", 10, 2),
            ("이번학기", 3, 2),
            ("월간", 3, 2),
            ("투데이", 1, 5)
        ]
    }
    
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
        Text("calendar")
    }
    
    /// 하단 기록 뷰
    var record: some View {
        VStack(spacing: 13.adjustToScreenHeight) {
            ForEach(0..<records.count / 2, id: \.self) { index in
                HStack(spacing: 13.adjustToScreenWidth) {
                    RecordCell(record: records[index * 2])
                    RecordCell(record: records[index * 2 + 1])
                }
            }
        }
    }
}

struct RecordCell: View {
    let record: (title: String, hours: Int, minutes: Int)
    
    var body: some View {
        HStack{
            VStack(alignment: .leading ,spacing: 8.adjustToScreenHeight) {
                Text(record.title)
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundStyle(.gray200)
                
                Text("\(record.hours)H \(record.minutes)M")
                    .font(.pretendard(size: 16, weight: .semibold))
                    .foregroundStyle(.gray100)
                
            }
            .padding(.vertical, 18.adjustToScreenHeight)
            .padding(.leading, 28.adjustToScreenWidth)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 88.adjustToScreenHeight)
        .background(.gray800)
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(.gray600, lineWidth: 1)
        )
    }
}


#Preview {
    RecordView()
}
