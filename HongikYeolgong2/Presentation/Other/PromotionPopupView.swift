//
//  PromotionPopupView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 12/3/24.
//

import SwiftUI

struct PromotionPopupView: View {
    @State private var isPopupPresented = true
    
    private var promotionImage: Image = Image("onboarding01")
    
    var body: some View {
            // 프로모션 팝업
            if isPopupPresented {
                ZStack {
                    // 반투명 배경
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            isPopupPresented = false
                        }
                    
                    // 팝업 뷰
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            // 프로모션 이미지
                            promotionImage
                                .resizable()
                                .scaledToFit()
                                .background(.gray300)
                            
                            // "자세히 보기" 버튼
                            Button(action: {
                                print("자세히 보기 tapped")
                                // 상세 페이지로 이동 또는 링크 오픈 처리
                            }) {
                                Text("자세히 보기 >")
                                    .font(.pretendard(size: 16, weight: .semibold))
                                    .padding(.vertical, 16)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.black)
                            }
                        }
                        .background(.white)
                        .cornerRadius(16)
                        
                        HStack(spacing: 16) {
                            // "오늘 그만 보기" 버튼
                            Button(action: {
                                // 오늘 그만 보기를 처리
                                isPopupPresented = false
                            }) {
                                Text("오늘 그만 보기")
                                    .font(.pretendard(size: 14, weight: .regular))
                                    .foregroundColor(.gray100)
                                    .padding(18)
                                    .frame(maxWidth: .infinity)
                            }
                            
                            Text("|")
                                .font(.pretendard(size: 14, weight: .thin))
                            
                            // "닫기" 버튼
                            Button(action: {
                                isPopupPresented = false
                            }) {
                                Text("닫기")
                                    .font(.pretendard(size: 14, weight: .regular))
                                    .foregroundColor(.gray100)
                                    .padding(18)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .cornerRadius(16)
                    .padding(.horizontal, 30)
                }
            }
    }
}

#Preview {
    PromotionPopupView()
}
