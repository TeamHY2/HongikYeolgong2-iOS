//
//  WebView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/10/24.
//

import SwiftUI
import WebKit

struct WebViewWithNavigation: View {
    @Environment(\.presentationMode) var dismiss
    
    var url: String
    var title: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack {
                    Button(action: {
                    }, label: {
                        Image(.icClose)
                    })
                    .disabled(true)
                    .opacity(0)
                    
                    Spacer()
                    
                    Text(title)
                        .font(.pretendard(size: 18, weight: .bold), lineHeight: 22)
                        .foregroundStyle(.gray800)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss.wrappedValue.dismiss()
                    }, label: {
                        Image(.icClose)
                    })
                }
                .padding(.horizontal, 28.adjustToScreenWidth)
            }
            .frame(maxWidth: .infinity, minHeight: 52.adjustToScreenHeight)
            .background(.white)
            
            WebView(url: url)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct WebView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webView = WKWebView()
        
        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        guard let url = URL(string: url) else { return }
        
        webView.load(URLRequest(url: url))
    }
}
