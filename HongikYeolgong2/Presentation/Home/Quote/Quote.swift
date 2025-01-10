//
//  Quote.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/4/25.
//

import SwiftUI

struct Quote: View {
    var body: some View {
        VStack {
            Text("행동보다 빠르게 불안감을 \n 없앨 수 있는 것은 없습니다.")
                .font(.pretendard(size: 18, weight: .regular), lineHeight: 20)
                .foregroundColor(.gray100)
                .multilineTextAlignment(.center)
            
            Text("- 윌터 앤더슨")
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                .foregroundColor(.gray200)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    Quote()
}
