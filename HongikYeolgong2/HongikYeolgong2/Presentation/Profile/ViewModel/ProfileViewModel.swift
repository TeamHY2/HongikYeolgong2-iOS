//
//  ProfileViewModel.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/31/25.
//

protocol ProfileCoordinatorDelegate: AnyObject {
    func goToAuth()
}

final class ProfileViewModel {
    weak var coordinator: ProfileCoordinatorDelegate?
        
    func goToAuth() {
        coordinator?.goToAuth()
    }
}
