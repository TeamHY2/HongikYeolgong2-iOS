//
//  StudyPeriodView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/23/24.
//

import SwiftUI

struct StudyPeriodView: View {
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 11.adjustToScreenHeight) {
                HStack(spacing: 13.adjustToScreenWidth) {
                    Text("Start")
                        .font(.suite(size: 12, weight: .medium), lineHeight: 15.adjustToScreenHeight)
                        .foregroundStyle(.gray300)
                    Image(.lineArrow)
                        .offset(y: -3)
                }
                
                HStack(alignment: .firstTextBaseline, spacing: 6.adjustToScreenWidth) {
                    Text("11: 30")
                        .font(.suite(size: 30, weight: .black), lineHeight: 32.adjustToScreenHeight)
                        .foregroundColor(.gray100)
                    Text("AM")
                        .font(.suite(size: 14, weight: .medium), lineHeight: 32)
                        .foregroundStyle(.gray100)
                }
            }
            
            VStack(alignment: .leading, spacing: 11.adjustToScreenHeight) {
                HStack(spacing: 13.adjustToScreenWidth) {
                    Text("End")
                        .font(.suite(size: 12, weight: .medium), lineHeight: 15.adjustToScreenHeight)
                        .foregroundStyle(.gray300)
                }
                
                HStack(alignment: .firstTextBaseline, spacing: 6.adjustToScreenWidth) {
                    Text("11: 30")
                        .font(.suite(size: 30, weight: .black), lineHeight: 32.adjustToScreenHeight)
                        .foregroundColor(.gray100)
                    Text("AM")
                        .font(.suite(size: 14, weight: .medium), lineHeight: 32.adjustToScreenHeight)
                        .foregroundStyle(.gray100)
                }
            }
            .padding(.leading, 18.adjustToScreenWidth)
            
            Spacer()
        }
    }
}

#Preview {
    StudyPeriodView()
}
