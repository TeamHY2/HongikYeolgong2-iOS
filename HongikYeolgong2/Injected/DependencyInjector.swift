//
//  DependencyInjector.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import SwiftUI
import Combine

/// DIContainer로 appState, Interactor를 주입
struct DIContainer: EnvironmentKey {
    let appState: Store<AppState>
    let interactors: Interactors
    let services: Services
    
    init(appState: Store<AppState>, 
         interactors: Interactors, 
         services: Services) {
        self.appState = appState
        self.interactors = interactors
        self.services = services
    }
    
    static var defaultValue: Self { Self.default }
    
    private static let `default` = Self(appState: .init(AppState()),
                                        interactors: .default,
                                        services: .init(appleAuthService: AppleLoginManager()))
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

extension View {
    //    func inject(_ appState: AppState) -> some View {
    //        let container = DIContainer(appState: .init(appState),
    //                                    interactors: .init(userDataInteractor: UserDataInteractorImpl(appState: .init(AppState()))))
    //        return inject(container)
    //    }
    
    func inject(_ container: DIContainer) -> some View {
        return self
            .environment(\.injected, container)
    }
}
