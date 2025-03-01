//
//  RecordCell.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/5/24.
//

import SwiftUI

enum RecordCellType{
    case year
    case month
}

struct RecordCell: View {
    let celltype: RecordCellType
    let date: Date
    let hours: Int
    let minutes: Int
    
    init(celltype: RecordCellType, date: Date?, hours: Int, minutes: Int) {
        self.celltype = celltype
        self.date = date ?? Date()
        self.hours = hours
        self.minutes = minutes
    }
    
    var body: some View {
        VStack(alignment: .center ,spacing: 8.adjustToScreenHeight) {
            HStack(spacing: 2.adjustToScreenWidth){
                Image(getImageForCelltype())
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16.adjustToScreenWidth,
                           height: 16.adjustToScreenHeight)
                Text(getTitleString())
                    .font(.suite(size: 12, weight: .medium))
                    .foregroundStyle(.gray200)
            }
            
            Text("\(hours)H \(minutes)M")
                .font(.pretendard(size: 16, weight: .bold))
                .foregroundStyle(.gray100)
            
        }
        .frame(maxWidth: .infinity)
        .frame(height: 76.adjustToScreenHeight)
        .background(
            
            LinearGradient(
                colors: [
                    Color(.sRGB, red: 18/255, green: 20/255, blue: 24/255, opacity: 1),
                    Color(.sRGB, red: 20/255, green: 24/255, blue: 33/255, opacity: 1)
                ],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(.gray800, lineWidth: 1)
        )
    }
    
    private func getImageForCelltype() -> ImageResource {
        switch celltype {
            case .year:
                    .clock
            case .month:
                    .calendarDots
        }
    }
    
    private func getTitleString() -> String {
        switch celltype {
            case .year:
                date.getYearString() + "년"
            case .month:
                date.formattedMonth() + "월"
        }
    }
}

