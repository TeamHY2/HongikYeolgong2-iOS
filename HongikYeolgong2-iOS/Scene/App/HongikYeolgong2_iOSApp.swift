

import SwiftUI
import Firebase

@main
struct HongikYeolgong2_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            InitialView()
                .environmentObject(AppCoordinator())
                .environmentObject(AuthCoordinator())
                .environmentObject(AuthenticationViewModel())
                .environmentObject(TimerViewModel())
                .environmentObject(CalendarViewModel())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        setupDependency()
        
        return true
    }
    
    func setupDependency() {
        DIContainer.shared.register(type: AuthenticationServiceType.self, service: AuthenticationService())
        DIContainer.shared.register(type: StudyRoomRepositoryType.self, service: StudyRoomRepository())
        DIContainer.shared.register(type: UserRepositoryType.self, service: UserRepository())
    }
}


