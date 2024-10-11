//
//  OnboardingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.injected) var injected: DIContainer
    
    @State private var seletedIndex = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            TabView(selection: $seletedIndex) {
                Image(.onboarding01)
                    .tag(0)
                Image(.onboarding02)
                    .tag(1)
                Image(.onboarding03)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack(spacing: 16) {
                ForEach(0..<3, id: \.self) { index in
                    Group {
                        if index == seletedIndex {
                            Image(.shineCount02)
                                .frame(width: 9, height: 9)
                        } else {
                            Circle()
                                .frame(width: 9, height: 9)
                                .foregroundColor(.gray600)
                        }
                    }
                }
            }
            
            HY2Button(title: "",
                      style: .imageButton(image: .snsLogin)) {
                injected.interactors.userDataInteractor.login()
            }
                      .padding(EdgeInsets(top: 32,
                                          leading: 32,
                                          bottom: 20,
                                          trailing: 32))
        }
    }
}

