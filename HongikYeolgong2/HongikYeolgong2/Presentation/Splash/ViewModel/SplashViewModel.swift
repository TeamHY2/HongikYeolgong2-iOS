//
//  SplashViewModel.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//

protocol SplashCoordinatorDelegate: AnyObject {
    func goToHome()
    func goToAuth()
}

final class SplashViewModel {
    var userInfoUseCase: UserInfoUseCase
    weak var coordinator: SplashCoordinatorDelegate!
    
    init(userInfoUseCase: UserInfoUseCase) {
        self.userInfoUseCase = userInfoUseCase        
    }
    
    func checkLogin() {
        let loginResult = userInfoUseCase.checkLogin()
        if loginResult {
            coordinator.goToHome()
        } else {
            coordinator.goToAuth()
        }
    }
}
