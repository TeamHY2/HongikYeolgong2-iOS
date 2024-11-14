//
//  SplashView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct SplashView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let storyboard = UIStoryboard(name: "Launch Screen", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        viewController.view.frame = UIScreen.main.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}    
