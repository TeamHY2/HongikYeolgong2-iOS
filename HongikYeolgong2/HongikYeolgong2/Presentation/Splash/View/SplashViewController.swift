//
//  SplashViewController.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//

import UIKit
import SnapKit
import Then

class SplashViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel: SplashViewModel
    
    private let logoImage = UIImageView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "logo")
        $0.frame.size.width = 70
        $0.frame.size.height = 70
    }
    
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.checkLogin()
    }
    
    // MARK: - UI
    
    func setupUI() {
        view.addSubview(logoImage)
        view.backgroundColor = .dark
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
