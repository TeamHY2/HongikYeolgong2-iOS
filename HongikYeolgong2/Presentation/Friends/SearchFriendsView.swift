//
//  SearchFriendsView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/17/25.
//

import SwiftUI

struct SearchFriendsView: View {
    @State var text: String = ""
    
    var body: some View {
        VStack(spacing: 2.adjustToScreenWidth){
            // 검색창
            HStack{
                // 뒤로가기 버튼
                Button {
                    // 페이지 나가기
                    
                } label: {
                    Image(.icProfileLeft)
                }
                
                // 검색창
                HStack {
                    Image(.magnifyingGlass)
                    
                    TextField(text: $text) {
                        Text("친구를 검색해보세요")
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundStyle(.gray300)
                    }
                    .frame(maxWidth: .infinity)
                    
                    if !text.isEmpty {
                        Image(.close)
                            .onTapGesture {
                                text = ""
                            }
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 12)
                .padding(.vertical, 12)
                .background(
                    .gray800
                )
                .cornerRadius(12)
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
            
            
            // 친구 리스트
            ScrollView {
                VStack(spacing: 24.adjustToScreenHeight){
                    ForEach(0..<10){ i in
                        FriendRequestCell()
                    }
                }
                .padding(.top, 22.adjustToScreenHeight)
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
        }
        //.padding(.top, 32.adjustToScreenHeight)
        .modifier(IOSBackground())
    }
}
