//
//  MenuView.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/2/24.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject private var coordinator: AppCoordinator
    
    var body: some View {
        VStack {
           
        }
        .customNavigation(left: {
            Button(action: {
                coordinator.pop()
            }, label: {
                Image(.icBack)
            })
        })
    }
}

#Preview {
    MenuView()
}
