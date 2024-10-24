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
        NavigationView {
            content
                .onReceive(routingUpdate) { self.routingState = $0 }
        }
    }
    
    // MARK: - Main Contents
    private var content: some View {
        VStack {
            Spacer()
            onboardingPageView
            pageIndicator
            appleLoginButton
            hiddenNavigationLink
        }
    }
    
    // MARK: - UI Components
    private var onboardingPageView: some View {
        TabView(selection: $tabIndex) {
            Image(.onboarding01)
                .tag(0)
            Image(.onboarding02)
                .tag(1)
            Image(.onboarding03)
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
    
    private var pageIndicator: some View {
        HStack(spacing: 16.adjustToScreenWidth) {
            ForEach(0..<3, id: \.self) { index in
                indicatorDot(for: index)
            }
        }
    }
    
    private func indicatorDot(for index: Int) -> some View {
        Group {
            if index == tabIndex {
                Image(.shineCount02)
                    .frame(width: 9, height: 9)
            } else {
                Circle()
                    .frame(width: 9, height: 9)
                    .foregroundColor(.gray600)
            }
        }
    }
    
    private var appleLoginButton: some View {
        Button(action: {}) {
            Image(.snsLogin)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 52)
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .padding(.top, 32.adjustToScreenHeight)
        .padding(.bottom, 20.adjustToScreenHeight)
        .overlay(
            SignInWithAppleButton(
                onRequest: onRequestAppleLogin,
                onCompletion: onCompleteAppleLogin
            )
            .blendMode(.destinationOver)
        )
    }
    
    private var hiddenNavigationLink: some View {
        NavigationLink("", 
                       destination: SignUpView(),
                       isActive: routingBinding.signUp)
        .opacity(0)
        .frame(width: 0, height: 0)
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
