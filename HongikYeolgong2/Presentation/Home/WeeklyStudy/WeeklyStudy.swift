//
//  WeeklyStudy.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/4/25.
//

import SwiftUI

struct WeeklyStudy: View {
    var body: some View {
        HStack {
            ForEach(0..<7, id: \.self) { number in
                if number != 0 && number != 7 {
                    Spacer()
                }
                WeeklyStudyCell()
            }
        }
        .padding(.top, 32)
    }
}

struct WeeklyStudyCell: View {
    var body: some View {
        VStack {
            Text("월")
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                .foregroundStyle(.gray400)
            
            VStack {
                Image(.shineCount00)
            }
            .frame(height: 28)
            .padding(.top, 8)
            .padding(.bottom, 2)
            
            Text("1/1")
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                .foregroundStyle(.gray400)
        }
    }
}

//#Preview {
//    WeeklyStudy()
//}
