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
    
    @Binding var isPresented: Bool
    
     init(isPresented: Binding<Bool>,
          title: String,
          confirmButtonText: String,
          cancleButtonText: String,
          confirmAction: (() -> Void)?,
          cancleAction: (() -> Void)? = nil) {
        self.confirmButtonText = confirmButtonText
        self._isPresented = isPresented
        self.cancleButtonText = cancleButtonText
        self.title = title
        self.confirmAction = confirmAction
        self.cancleAction = cancleAction
        
    }
    
    init(isPresented: Binding<Bool>,
         title: String,
         confirmAction: (() -> Void)?,
         cancleAction: (() -> Void)? = nil) {
        self.title = title
        self._isPresented = isPresented
        self.confirmAction = confirmAction
        self.cancleAction = cancleAction
    }
    
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 40.adjustToScreenHeight)
            
            // title
            Text(title)
                .font(.pretendard(size: 18, weight: .semibold))
                .foregroundStyle(.gray100)
            
            Spacer().frame(height: 30.adjustToScreenHeight)
            
            HStack {
                Button(action: {
                    cancleAction?()
                    isPresented = false
                }) {
                    Text(cancleButtonText)
                        .font(.pretendard(size: 16, weight: .semibold))
                        .foregroundStyle(.gray200)
                        .frame(maxWidth: .infinity, minHeight: 46.adjustToScreenHeight)
                }
                .background(.gray600)
                .cornerRadius(8)
                
                Spacer().frame(width: 12.adjustToScreenWidth)
                
                Button(action: {
                    confirmAction?()
                    isPresented = false
                }) {
                    Text(confirmButtonText)
                        .font(.pretendard(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, minHeight: 46.adjustToScreenHeight)
                }
                .background(.blue100)
                .cornerRadius(8)
                
            }
            .padding(.horizontal, 24.adjustToScreenWidth)
            
            Spacer().frame(height: 30.adjustToScreenHeight)
        }
        .frame(maxWidth: 316.adjustToScreenWidth)
        .background(.gray800)
        .cornerRadius(8)
        
    }
}


//#Preview {
//    ModalView()
//}
