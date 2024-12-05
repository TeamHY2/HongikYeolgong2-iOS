//
//  PromotionPopupView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 12/3/24.
//

import SwiftUI
import AmplitudeSwift

struct PromotionPopupView: View {
    @Binding var isPromotionPopupPresented: Bool
    let promotionData: PromotionData
    // 자세히 보기 동작 함수
    let showWebView: () -> Void
    
    var body: some View {
        // 프로모션 팝업
        ZStack {
            // 반투명 배경
            Color.black.opacity(0.3)
                .ignoresSafeArea()
            
            // 팝업 뷰
            VStack(spacing: 0) {
                
                VStack(spacing: 0) {
                    // 프로모션 이미지
                    if let image = promotionData.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .background(Color.gray.opacity(0.3))
                            .onTapGesture {
                                promotionDetailPresent()
                            }
                    }
                    // "자세히 보기" 버튼
                    Button(action: {
                        // 상세 페이지 보여주기
                        promotionDetailPresent()
                    }) {
                        Text("자세히 보기 >")
                            .font(.pretendard(size: 16, weight: .semibold))
                            .foregroundColor(.gray800)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.black)
                            .background(.white)
                    }
                }
                .cornerRadius(16)
                
                HStack(spacing: 16) {
                    // "오늘 그만 보기" 버튼
                    Button(action: {
                        // 오늘 그만 보기를 처리
                        dismissTodayPopup()
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
                        dismissPopup()
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
            .padding(.horizontal, 30.adjustToScreenWidth)
        }
    }
}

// MARK: - Helpers
extension PromotionPopupView {
    /// "자세히 보기" 동작 함수
    private func promotionDetailPresent() {
        // Amplitude 추가
        Amplitude.instance.track(eventType: "PromotionPopupDetail")
        
        // RootView WepView표시
        showWebView()
    }
    
    /// "오늘 그만 보기" 동작 함수
    private func dismissTodayPopup() {
        // 금일 날짜 불러오기
        let todayDate = Date().toDateString()
        UserDefaults.standard.set(todayDate, forKey: "dismissedTodayKey")
        
        // Amplitude 추가
        Amplitude.instance.track(eventType: "PromotionPopupTodayClose")
        
        // view 닫기
        isPromotionPopupPresented = false
    }
    
    /// "닫기" 동작 함수
    private func dismissPopup() {
        // Amplitude 추가
        Amplitude.instance.track(eventType: "PromotionPopupClose")
        
        // view 닫기
        isPromotionPopupPresented = false
    }
}
