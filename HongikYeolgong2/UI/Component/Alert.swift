//
//  Alert.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/24/24.
//

import SwiftUI
import Combine

struct AlertModifier: ViewModifier {
    
    var confirmButtonText: String = "네"
    var cancleButtonText: String = "아니오"
    
    let title: String
    let confirmAction: (() -> Void)?
    let cancleAction: (() -> Void)?
    
    @State private var scale: CGFloat = 1
    
    @Binding var isPresented: Bool
    
    init(title: String, confirmButtonText: String, cancleButtonText: String, confirmAction: (() -> Void)?, cancleAction: (() -> Void)? = nil, isPresented: Binding<Bool>) {
        self.confirmButtonText = confirmButtonText
        self.cancleButtonText = cancleButtonText
        self.title = title
        self.confirmAction = confirmAction
        self.cancleAction = cancleAction
        self._isPresented = isPresented
    }
    
    init(title: String, confirmAction: (() -> Void)?, cancleAction: (() -> Void)? = nil, isPresented: Binding<Bool>) {
        self.title = title
        self.confirmAction = confirmAction
        self.cancleAction = cancleAction
        self._isPresented = isPresented
    }
    
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isPresented {
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
                                    isPresented = false
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
                                    isPresented = false
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
                        .scaleEffect(scale)
                        .animation(.interpolatingSpring(mass: 1.0, stiffness: 200, damping: 15), value: scale)
                        }
                        
                        .onReceive(Just(isPresented), perform: { newValue in
                            if newValue {
                                scale = 1.0
                            } else {
                                scale = 0.9
                            }
                        })
                }
            }
    }
}

extension View {
    func alert(title: String, isPresented: Binding<Bool>, confirmAction: (() -> Void)?, cancelAction: (() -> Void)?) -> some View {
        modifier(AlertModifier(title: title, confirmAction: confirmAction, cancleAction: cancelAction, isPresented: isPresented))
    }
    
    func alert(title: String, isPresented: Binding<Bool>, confirmAction: (() -> Void)?) -> some View {
        modifier(AlertModifier(title: title, confirmAction: confirmAction, isPresented: isPresented))
    }
    
    func alert(title: String, confirmButtonText: String, cancleButtonText: String, isPresented: Binding<Bool>, confirmAction: (() -> Void)?, cancelAction: (() -> Void)?) -> some View {
        modifier(AlertModifier(title: title, 
                               confirmButtonText: confirmButtonText, cancleButtonText: cancleButtonText, confirmAction: confirmAction, cancleAction: cancelAction, isPresented: isPresented))
    }
    
    func alert(title: String, confirmButtonText: String, cancleButtonText: String, isPresented: Binding<Bool>, confirmAction: (() -> Void)?) -> some View {
        modifier(AlertModifier(title: title, confirmButtonText: confirmButtonText, cancleButtonText: cancleButtonText, confirmAction: confirmAction, isPresented: isPresented))
    }
}
