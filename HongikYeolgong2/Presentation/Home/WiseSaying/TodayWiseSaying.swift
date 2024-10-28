//
//  TodayWiseSaying.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/5/24.
//

import SwiftUI

struct TodayWiseSaying: View {
    let wiseSaying: WiseSaying
    
    var body: some View {
        VStack(spacing: 12) {
            Text(wiseSaying.quote)
                .font(.pretendard(size: 18, weight: .regular), lineHeight: 28)
                .foregroundColor(.gray100)
                .multilineTextAlignment(.center)
            
            Text("-\(wiseSaying.author)")
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                .foregroundColor(.gray200)
                .multilineTextAlignment(.center)
        }
    }
}

//#Preview {
//    TodayWiseSaying()
//}
