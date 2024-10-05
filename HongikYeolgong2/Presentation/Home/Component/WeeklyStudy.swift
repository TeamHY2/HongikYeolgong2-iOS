//
//  WeeklyStudy.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/5/24.
//

import SwiftUI

struct WeeklyStudy: View {
    var body: some View {
        HStack {
            ForEach(1...7, id: \.self) { number in
                VStack(spacing: 0) {
                    Text("월")
                        .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                        .foregroundStyle(.white)
                    
                    Image(.star)
                        .padding(.top, 8)
                        .padding(.bottom, 2)
                    
                    Text("9/23")
                        .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                        .foregroundStyle(.white)
                }
                if number != 7 {
                    Spacer()
                }
            }
        }
        .padding(.top, 33)
    }
}

#Preview {
    WeeklyStudy()
}
