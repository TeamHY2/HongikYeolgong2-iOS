//
//  TabBarViewController.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/31/25.
//

import UIKit
import SnapKit
import Then

final class TabBarViewController: UIViewController {
    
    private lazy var viewControllers: [UIViewController] = []
    private lazy var buttons: [UIButton] = []
    
    private lazy var tabBarView = UIView().then {
        $0.backgroundColor = .gray800
        $0.layer.cornerRadius = 16
    }
    
    private lazy var tabButtonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    var selectedIndex = 0 {
        willSet {
            previewsIndex = selectedIndex
        }
        didSet {
            updateView()
        }
    }
    private var previewsIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        // Do any additional setup after loading the view.
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        setupButton()
        updateView()
    }
    
    private func setupTabBar() {
        view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview()
            $0.height.equalTo(88)
        }
    }
    
    private func setupButton() {
        tabBarView.addSubview(tabButtonStack)
        
        tabButtonStack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(tabBarView).offset(12)
            $0.height.equalTo(50)
        }
        
        for (index, _) in viewControllers.enumerated() {
            let button = UIButton()
            let imageName = getImageName(index)
            button.setImage(UIImage(named: imageName), for: .normal)
            button.setImage(UIImage(named: imageName + "Selected"), for: .selected)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            tabButtonStack.addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    func setupView() {
        let selectedVC = viewControllers[selectedIndex]
        
        self.addChild(selectedVC)
        view.insertSubview(selectedVC.view, belowSubview: tabBarView)
        selectedVC.view.frame = view.bounds
        selectedVC.didMove(toParent: self)
    }
    
    private func deleteView() {
        let previousVC = viewControllers[previewsIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
    }
    
    func updateView() {
        deleteView()
        setupView()
        
        buttons.forEach { $0.isSelected = ($0.tag == selectedIndex) }
    }
    
    func getImageName(_ index: Int) -> String {
        switch index {
        case 0:
            "home"
        case 1:
            "record"
        case 2:
            "ranking"
        case 3:
            "profile"
        default:
            ""
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
}
