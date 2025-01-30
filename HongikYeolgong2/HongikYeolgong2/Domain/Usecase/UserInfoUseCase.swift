//
//  UserInfoUseCase.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//

protocol UserInfoUseCase {
    func checkLogin() -> Bool
}

final class DefaultUserInfoUseCase: UserInfoUseCase {
    func checkLogin() -> Bool {
        return false
    }
}
