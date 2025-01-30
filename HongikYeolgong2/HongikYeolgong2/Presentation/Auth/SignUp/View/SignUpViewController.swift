//
//  SignUpViewController.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/20/25.
//

import UIKit
import Then
import SnapKit

class SignUpViewController: UIViewController {
    let viewModel: SignUpViewModel
    private let loginButton = UIButton().then {
        $0.setTitle("login", for: .normal)
        $0.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginButton)
        setupConstraints()
    }
    
    func setupConstraints() {
        loginButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc func loginButtonTapped() {
        viewModel.goToHome()
    }
}
