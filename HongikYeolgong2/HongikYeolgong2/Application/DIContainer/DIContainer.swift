//
//  DIContainer.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//
import UIKit

protocol AppFlowCoordinatorDependencies  {
    func makeSplashViewController() -> UIViewController
}

final class DIContainer: AppFlowCoordinatorDependencies {
    
    struct Dependencies {
        
    }
    
    private let dependencies: Dependencies
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - UseCases
    
    func makeStudyRoomUseCase() -> StudyRoomUseCase {
        DefaultStudyRoomUseCase(studyRoomRepository: makeStudyRoomRepository())
    }
    
    func makeUserInfoUseCase() -> UserInfoUseCase {
        DefaultUserInfoUseCase()
    }
    
    // MARK: - Repositories
    
    func makeStudyRoomRepository() -> StudyRoomRepository {
        DefaultSutdyRoomRepository()
    }
    
    // MARK: - ViewModel
    
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(studyRoomUseCase: makeStudyRoomUseCase())
    }
    
    func makeSplashViewModel() -> SplashViewModel {
        SplashViewModel(userInfoUseCase: makeUserInfoUseCase())
    }
    
    func makeRecordViewModel() -> RecordViewModel {
        RecordViewModel()
    }
    
    func makeRankingViewModel() -> RankingViewModel {
        RankingViewModel()
    }
    
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel()
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        SignUpViewModel()
    }
    
    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }
    
    // MARK: - FlowCoordiantor
    
    func makeAuthCoordinator(navigationController: UINavigationController) -> AuthCoordinator {
        AuthCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeSplashCoordinator(navigationController: UINavigationController) -> SplashCoordinator {
        SplashCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinator {
        HomeCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeRecordCoordinator(navigationController: UINavigationController) -> RecordCoordinator {
        RecordCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeMainTabCoordinator(navigationController: UINavigationController) -> MainTabCoordinator {
        MainTabCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeRankingCoordinator(navigationController: UINavigationController) -> RankingCoordinator {
        RankingCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    func makeProfileCoordinator(navigationController: UINavigationController) -> ProfileCoordinator {
        ProfileCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    // MARK: - ViewControllers
    
    func makeSplashViewController() -> UIViewController {
        SplashViewController(viewModel: makeSplashViewModel())
    }
}


