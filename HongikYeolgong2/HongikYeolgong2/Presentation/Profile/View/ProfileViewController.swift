//
//  ProfileViewController.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/31/25.
//

import UIKit
import SnapKit
import Then

class ProfileViewController: UIViewController {
    let viewModel: ProfileViewModel
    private lazy var logoutButton = UIButton().then {
        $0.setTitle("logout", for: .normal)
        $0.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        view.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    @objc func logoutButtonTapped() {
        viewModel.goToAuth()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
