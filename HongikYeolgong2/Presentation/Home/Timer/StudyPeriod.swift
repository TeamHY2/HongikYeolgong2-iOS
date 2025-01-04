//
//  StudyPeriod.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/4/25.
//

import SwiftUI

struct StudyPeriod: View {
    let startTime: Date
    let endTime: Date
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 11) {
                HStack(spacing: 13) {
                    Text("Start")
                        .font(.suite(size: 12, weight: .medium), lineHeight: 15)
                        .foregroundStyle(.gray300)
                    Image(.lineArrow)
                        .offset(y: -3)
                }
                
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(startTime.getHourMinutes())
                        .font(.suite(size: 30, weight: .black), lineHeight: 32)
                        .foregroundColor(.gray100)
                    Text(startTime.getDaypart())
                        .font(.suite(size: 14, weight: .medium), lineHeight: 32)
                        .foregroundStyle(.gray100)
                }
            }
            
            VStack(alignment: .leading, spacing: 11) {
                HStack(spacing: 13) {
                    Text("End")
                        .font(.suite(size: 12, weight: .medium), lineHeight: 15)
                        .foregroundStyle(.gray300)
                }
                
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(endTime.getHourMinutes())
                        .font(.suite(size: 30, weight: .black), lineHeight: 32)
                        .foregroundColor(.gray100)
                    Text(endTime.getDaypart())
                        .font(.suite(size: 14, weight: .medium), lineHeight: 32)
                        .foregroundStyle(.gray100)
                }
            }
            .padding(.leading, 18)
            
            Spacer()
        }
    }
}


//#Preview {
//    StudyPeriod(startTime: .now, endTime: .now)
//}
