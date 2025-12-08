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
    func getFriendsTimeList(serchUsers: LoadableSubject<[FriendStudyTime]>, dateType: RankingType)
    func respondFriendRequest(info: Notification, isAccept: Bool, completion: @escaping (Bool) -> Void)
    func requestCancelFriend(userId: Int, completion: @escaping (Bool) -> Void)
    func getNotificationList(notificationList: LoadableSubject<[Notification]>)
}

final class FriendInteractorImpl: FriendInteractor {
    private let friendRepository: FriendRepository
    private let cancleBag = CancelBag()
    private var firstLoading: Bool = true
    
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
    
    // 친구 랭킹 리스트 요청
    func getFriendsTimeList(serchUsers: LoadableSubject<[FriendStudyTime]>, dateType: RankingType) {
        if firstLoading{
            friendRepository
                .getFriendsTimeList(dateType: dateType)
                .sinkToLoadble(serchUsers)
                .store(in: cancleBag)
            firstLoading.toggle()
        } else {
            friendRepository
                .getFriendsTimeList(dateType: dateType)
                .sinkToLoadbleWithoutLoding(serchUsers)
                .store(in: cancleBag)
        }
    }
    
    // 친구 요청 수락, 거절
    func respondFriendRequest(info: Notification, isAccept: Bool, completion: @escaping (Bool) -> Void) {
        friendRepository
            .respondFriendRequest(info: info, isAccept: isAccept)
            .sink { _ in }
        receiveValue: {
            completion($0)
        }
        .store(in: cancleBag)
    }
    
    // 친구 요청 취소
    func requestCancelFriend(userId: Int, completion: @escaping (Bool) -> Void) {
        friendRepository
            .requestCancelFriend(userId: userId)
            .sink { _ in }
        receiveValue: {
            completion($0)
        }
        .store(in: cancleBag)
    }
    
    // 알림 리스트 요청
    func getNotificationList(notificationList: LoadableSubject<[Notification]>) {
        friendRepository
            .getNotification()
            .sinkToLoadble(notificationList)
            .store(in: cancleBag)
        firstLoading.toggle()
    }
}
