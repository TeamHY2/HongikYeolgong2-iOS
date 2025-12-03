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
    @State private var isToastShow: Bool = false
    @State private var toastText: String = ""
    
    //
    @FocusState private var isFocused: Bool
    
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
                    .focused($isFocused)
                    .frame(maxWidth: .infinity)
                    .onChange(of: inputNickname) { newValue in
                        inputSubject.send(newValue)
                    }
                    
                    if !inputNickname.isEmpty {
                        Image(.close)
                            .transition(.opacity)
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
                .animation(.easeInOut(duration: 0.15), value: inputNickname.isEmpty)
            }
            .padding(.top, 33.adjustToScreenHeight)
            .padding(.horizontal, 32.adjustToScreenWidth)
            
            
            // 친구 리스트
            ScrollView {
                VStack(spacing: 24.adjustToScreenHeight){
                    ForEach(searchResults, id: \.self){ user in
                        FriendRequestCell(user: user) {
                            requestAddFriend(user)
                        } calcelAction: {
                            requestCancelFriend(user)
                        }
                    }
                }
                .padding(.top, 22.adjustToScreenHeight)
                .padding(.horizontal, 32.adjustToScreenWidth)
            }
        }
        .modifier(IOSBackground())
        .onAppear {
            // 뷰 열리자마자 키보드 띄우기
            isFocused = true
        }
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
        .toast(isToastShow: $isToastShow, text: toastText)
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
    private func requestAddFriend(_ user: SearchUser) {
        let userId = user.userId
        guard let index = searchResults.firstIndex(where: { $0.userId == userId }) else { return }
        
        // 로딩 상태 세팅
        searchResults[index].friendStatus = .loading
        
        friendInteractor.postAddFriend(userId: userId) { success in
            if success {
                searchResults[index].friendStatus = .pending
                showToast(text: user.nickname + "님에게 친구추가 요청을 보냈어요.")
            } else {
                // 찬구 신청 상태 변경 (이후 로딩 및 처리 방식 변경)
                searchResults[index].friendStatus = .none
            }
        }
    }
    
    // 친구 취소 요청
    private func requestCancelFriend(_ user: SearchUser) {
        let userId = user.userId
        guard let index = searchResults.firstIndex(where: { $0.userId == userId }) else { return }
        
        // 로딩 상태 세팅
        searchResults[index].friendStatus = .loading
        
        friendInteractor.requestCancelFriend(userId: userId) { success in
            if success {
                searchResults[index].friendStatus = .none
                showToast(text: user.nickname + "님에게 보낸 친구 요청을 취소했어요.")
            } else {
                // 찬구 신청 상태 변경 (이후 로딩 및 처리 방식 변경)
                searchResults[index].friendStatus = .pending
            }
        }
    }
    
    private func showToast(text: String) {
        withAnimation {
            toastText = text
            isToastShow.toggle()
        }
    }
}
