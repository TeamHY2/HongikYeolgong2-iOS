//
//  PromotionPopupView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 12/3/24.
//

import SwiftUI
import WebKit

struct PromotionPopupView: View {
    @Binding var isPromotionPopupPresented: Bool
    @State private var isWebViewPresented = false
    
    let promotionDetail: String = "https://www.naver.com/"
    
    private var promotionImage: Image = Image("onboarding01")
    
    init(isPromotionPopupPresented: Binding<Bool>, isWebViewPresented: Bool = false, promotionImage: Image = Image("onboarding01")) {
        self._isPromotionPopupPresented = isPromotionPopupPresented
        self.isWebViewPresented = isWebViewPresented
        self.promotionImage = promotionImage
    }
    
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
                    promotionImage
                        .resizable()
                        .scaledToFit()
                        .background(.gray300)
                        .onTapGesture {
                            promotionDetailPresent()
                        }
                    // "자세히 보기" 버튼
                    Button(action: {
                        // 상세 페이지 보여주기
                        promotionDetailPresent()
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
        .fullScreenCover(isPresented: $isWebViewPresented) {
            WebViewWithNavigation(url: promotionDetail, title: "프로모션")
        }
    }
}

// MARK: - Helpers
extension PromotionPopupView {
    /// "자세히 보기" 동작 함수
    private func promotionDetailPresent() {
        // promotionUrl -> 웹뷰 표시
        isWebViewPresented.toggle()
    }
    
    /// "오늘 그만 보기" 동작 함수
    private func dismissTodayPopup() {
        // 금일 날짜 불러오기
        let todayDate = Date().toDateString()
        
        print("📅제외 날짜 \(todayDate) 세팅 완료")
        UserDefaults.standard.set(todayDate, forKey: "dismissedTodayKey")
        
        // Amplitude 추가
        
        // view 닫기
        isPromotionPopupPresented = false
    }
    
    /// "닫기" 동작 함수
    private func dismissPopup() {
        // Amplitude 추가
        
        // view 닫기
        isPromotionPopupPresented = false
    }
}
