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
            Image(systemName: "exclamationmark.octagon.fill")
                .font(.system(size: 48))
                .foregroundColor(.blue100)
            
            Text("네트워크가 통신이 원할하지 않습니다.\n확인 후 다시 시도해주시기 바랍니다")
                .multilineTextAlignment(.center)
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
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(.gray600)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    // 다시 시도 함수
                    retryAction()
                }) {
                    Text("다시시도")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity)
                        .background(.blue100)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 24)
        }
        .padding()
        .background(.gray800)
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding(.horizontal, 40)
    }
}
