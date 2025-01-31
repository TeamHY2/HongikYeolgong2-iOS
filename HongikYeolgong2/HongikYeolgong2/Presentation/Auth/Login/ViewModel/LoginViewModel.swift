//
//  LoginViewModel.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/31/25.
//

protocol LoginCoordinatorDelegate: AnyObject {
    func goToSignUp()
    func goToHome()
}

final class LoginViewModel {
    weak var coordinator: LoginCoordinatorDelegate?
    
    func goToSignup() {
        coordinator?.goToSignUp()
    }
}
