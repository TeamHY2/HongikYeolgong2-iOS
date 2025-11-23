//
//  SearchFriendsView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/17/25.
//

import SwiftUI
import Combine

struct SearchFriendsView: View {
    @Environment(\.injected.interactors.friendInteractor) var friendInteractor
    @EnvironmentObject var router: AppRouter
    @State var inputNickname: String = ""
    @State var searchResults: [SearchUser] = []
    
    // debounce 이벤트 발행 용도
    private let inputSubject = PassthroughSubject<String, Never>()
    
    var body: some View {
        VStack(spacing: 2.adjustToScreenWidth){
            // 검색창
            HStack{
                // 뒤로가기 버튼
                Button {
                    // 페이지 나가기
                    router.pop()
                } label: {
                    Image(.icProfileLeft)
                }
                
                // 검색창
                HStack {
                    Image(.magnifyingGlass)
                    
                    TextField(text: $inputNickname) {
                        Text("친구를 검색해보세요")
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundStyle(.gray300)
                    }
                    .frame(maxWidth: .infinity)
                    .onChange(of: inputNickname) { newValue in
                        inputSubject.send(newValue)
                    }
                    
                    if !inputNickname.isEmpty {
                        Image(.close)
                            .onTapGesture {
                                inputNickname = ""
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
                .padding(.horizontal, 32.adjustToScreenWidth)
            }
        }
        .modifier(IOSBackground())
        .onReceive(
            inputSubject
                .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
                .removeDuplicates() // 중복 제거
                .filter {
                    // 정규식 검사 및 비어있는 항목 제외
                    isValidPattern($0) && !$0.isEmpty
                }
        ) { inputNickname in
            requestSearch(inputNickname)
        }
    }
    
    // 정규식 검사
    private func isValidPattern(_ input: String) -> Bool {
        let pattern = "^[가-힣a-zA-Z\\s]*$"
        return input.range(of: pattern, options: .regularExpression) != nil
    }
    
    // 닉네임 검색 요청
    private func requestSearch(_ input: String) {        friendInteractor.getSerchUser(serchUsers: $searchResults, nickname: input)
    }
    
    // 친구 추가 요청
    private func requestAddFriend(_ userId: String) {
        
    }
}
