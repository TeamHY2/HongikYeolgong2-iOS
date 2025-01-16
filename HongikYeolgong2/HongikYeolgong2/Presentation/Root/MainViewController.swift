//
//  ViewController.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/15/25.
//

import UIKit
import Then

class MainViewController: UIViewController {
    
    // 확인용 -> 다른 작업시 바로 삭제
    private let testLabel = UILabel().then {
        $0.text = "Test"
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTestLable()
    }
    
    private func setupTestLable() {
        self.view.addSubview(testLabel)
        
        NSLayoutConstraint.activate([
            testLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            testLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
