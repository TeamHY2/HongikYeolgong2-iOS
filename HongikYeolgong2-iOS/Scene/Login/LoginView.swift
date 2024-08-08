

import SwiftUI
import AuthenticationServices
struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack{
            SignInWithAppleButton(onRequest: { request in                
                authViewModel.send(action: .appleLogin(request))
            }, onCompletion: { result in
                
                authViewModel.send(action: .appleLoginCompletion(result))
            })
            .frame(width: UIScreen.UIWidth(320), height: UIScreen.UIHeight(90))
        }
    }
}

#Preview {
    LoginView()
}
