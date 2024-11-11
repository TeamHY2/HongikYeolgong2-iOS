import SwiftUI
import Combine
import AuthenticationServices

struct OnboardingView: View {
    // MARK: - Properties
    @Environment(\.injected) private var injected: DIContainer
    
    // MARK: - States
    @State private var tabIndex = 0
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: injected.appState, \.routing.onboarding)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                OnboardingPageView(tabIndex: $tabIndex)
                                
                AppleLoginButton(
                    onRequest: onRequestAppleLogin,
                    onCompletion: onCompleteAppleLogin
                )
                
                NavigationLink(
                    destination: SignUpView(),
                    isActive: routingBinding.signUp
                ) {
                    EmptyView()
                }
                .opacity(0)
                .frame(width: 0, height: 0)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: - Apple Login Methods
private extension OnboardingView {
    func onRequestAppleLogin(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.email]
    }
    
    func onCompleteAppleLogin(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case let .success(authorization):
            injected.interactors.userDataInteractor
                .requestAppleLogin(authorization)
        case .failure:
            break
        }
    }
}

// MARK: - Routing
private extension OnboardingView {
    private var routingUpdate: AnyPublisher<Routing, Never> {
        injected.appState.updates(for: \.routing.onboarding)
    }
}

extension OnboardingView {
    struct Routing: Equatable {
        var signUp: Bool = false
    }
}

