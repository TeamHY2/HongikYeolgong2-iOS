//
//  ModalView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/28/24.
//

import SwiftUI

struct ModalView: View {
    
    var confirmButtonText: String = "네"
    var cancleButtonText: String = "아니오"
    
    let title: String
    let confirmAction: (() -> Void)?
    let cancleAction: (() -> Void)?        
    
    init(title: String,
         confirmButtonText: String,
         cancleButtonText: String,
         confirmAction: (() -> Void)?,
         cancleAction: (() -> Void)? = nil) {
        self.confirmButtonText = confirmButtonText
        self.cancleButtonText = cancleButtonText
        self.title = title
        self.confirmAction = confirmAction
        self.cancleAction = cancleAction
        
    }
    
    init(title: String,
         confirmAction: (() -> Void)?,
         cancleAction: (() -> Void)? = nil) {
        self.title = title
        self.confirmAction = confirmAction
        self.cancleAction = cancleAction
    }
    
    
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer().frame(height: 40)
                
                // title
                Text(title)
                    .font(.pretendard(size: 18, weight: .semibold))
                    .foregroundStyle(.gray100)
                
                Spacer().frame(height: 30)
                
                HStack {
                    Button(action: {
                        cancleAction?()
                    }) {
                        Text(cancleButtonText)
                            .font(.pretendard(size: 16, weight: .semibold))
                            .foregroundStyle(.gray200)
                            .frame(maxWidth: .infinity, minHeight: 46)
                    }
                    .background(.gray600)
                    .cornerRadius(8)
                    
                    Spacer().frame(width: 12)
                    
                    Button(action: {
                        confirmAction?()
                    }) {
                        Text(confirmButtonText)
                            .font(.pretendard(size: 16, weight: .semibold))
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 46)
                    }
                    .background(.blue100)
                    .cornerRadius(8)
                    
                }
                .padding(.horizontal, 24)
                
                Spacer().frame(height: 30)
            }
            .frame(maxWidth: 316)
            .background(.gray800)
            .cornerRadius(8)
        }
    }
}


//#Preview {
//    ModalView()
//}
