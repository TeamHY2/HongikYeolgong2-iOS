//
//  FriendInteractor.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/23/25.
//

import SwiftUI
import Combine

protocol FriendInteractor {
    func getSerchUser(serchUsers: Binding<[SearchUser]>, nickname: String)
    func postAddFriend(userId: Int, completion: @escaping (Bool) -> Void)
}

final class FriendInteractorImpl: FriendInteractor {
    private let friendRepository: FriendRepository
    private let cancleBag = CancelBag()
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    // 사용자 검색
    func getSerchUser(serchUsers: Binding<[SearchUser]>, nickname: String) {
        friendRepository
            .getSerchUser(nickname: nickname)
            .receive(on: DispatchQueue.main)
            .sink { _ in }
        receiveValue: {
            serchUsers.wrappedValue = $0
        }
        .store(in: cancleBag)
    }
    
    // 친구 요청
    func postAddFriend(userId: Int, completion: @escaping (Bool) -> Void) {
        friendRepository
            .postAddFriend(userId: userId)
            .receive(on: DispatchQueue.main)
            .sink { _ in }
        receiveValue: {
            completion($0)
        }
        .store(in: cancleBag)
    }
}
