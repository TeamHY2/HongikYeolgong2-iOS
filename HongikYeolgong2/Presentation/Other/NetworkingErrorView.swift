//
//  NetworkingErrorView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/9/24.
//

import SwiftUI

struct NetworkingErrorView: View {
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16.adjustToScreenHeight) {
            Image(.exclamationMark)
                .resizable()
                .frame(width: 50.adjustToScreenWidth, height: 50.adjustToScreenHeight)
            
            Text("네트워크가 연결되어 있지 않아.\n오류가 발생할 수 있습니다.")
                .multilineTextAlignment(.center)
                .font(.pretendard(size: 18, weight: .semibold))
                .foregroundColor(.gray100)
                .font(.body)
            
            Spacer()
                .frame(height: 0)
            
            HStack(spacing: 12.adjustToScreenWidth) {
                Button(action: {
                    exit(0)
                }) {
                    Text("종료하기")
                        .foregroundColor(.gray200)
                        .font(.pretendard(size: 16, weight: .bold))
                        .padding(.vertical, 10.adjustToScreenHeight)
                        .frame(maxWidth: .infinity)
                        .background(.gray600)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    // 다시 시도 함수
                    retryAction()
                }) {
                    Text("계속 이용하기")
                        .foregroundColor(.white)
                        .font(.pretendard(size: 16, weight: .bold))
                        .padding(.vertical, 10.adjustToScreenHeight)
                        .frame(maxWidth: .infinity)
                        .background(.blue100)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 24.adjustToScreenWidth)
        }
        .padding(.top,40.adjustToScreenHeight)
        .padding(.bottom,30.adjustToScreenHeight)
        .background(.gray800)
        .cornerRadius(8)
        .shadow(radius: 10)
        .padding(.horizontal, 30.adjustToScreenWidth)
    }
}
