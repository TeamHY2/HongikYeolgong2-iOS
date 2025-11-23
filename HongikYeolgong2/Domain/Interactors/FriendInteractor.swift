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
}

final class FriendInteractorImpl: FriendInteractor {
    private let friendRepository: FriendRepository
    private let cancleBag = CancelBag()
    
    init(friendRepository: FriendRepository) {
        self.friendRepository = friendRepository
    }
    
    func getSerchUser(serchUsers: Binding<[SearchUser]>, nickname: String) {
        friendRepository
            .getSerchUser(nickname: nickname)
            .receive(on: DispatchQueue.main)
            .sink { _ in }
        receiveValue: {
            print("========\(nickname) 검색된 유저 리스트========")
            print($0)
            serchUsers.wrappedValue = $0
        }
        .store(in: cancleBag)
    }
}
