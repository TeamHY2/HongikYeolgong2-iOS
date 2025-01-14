//
//  RecordCell.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/4/25.
//

import SwiftUI

struct Record: Equatable {
    var title: String
    var hours: Int
    var minutes: Int
}

struct RecordCell: View {
    let record: Record
    
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
