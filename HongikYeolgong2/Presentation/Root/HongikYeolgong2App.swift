//
//  HongikYeolgong2App.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI

@main
struct HongikYeolgong2App: App {
    @State private var selectedTab: Tab = .home
    
    var body: some Scene {
        WindowGroup {
            TimePickerDialog(selectedDate: .constant(.now))
        }
    }
}
