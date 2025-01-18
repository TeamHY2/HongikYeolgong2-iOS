//
//  LoginViewController.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/16/25.
//

import UIKit
import Then
import SnapKit

class LoginViewController: UIViewController {
    // onboarding 이미지
    private let onboardingImages = [
        UIImage.onboarding01,
        UIImage.onboarding02,
        UIImage.onboarding03
    ]
    
    // MARK: - UI Components
    private let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
    }
    
    private var pageControlStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
    }
    
    private let loginButton = UIButton().then {
        $0.setImage(UIImage(named: "snsLogin"), for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        addImageToStackView()
        scrollView.delegate = self
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        // 배경 이후 수정
        view.backgroundColor = .black
        
        view.addSubview(scrollView)
        view.addSubview(loginButton)
        view.addSubview(pageControlStackView)
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        pageControlStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginButton.snp.top).offset(-32)
        }
        
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - 클릭 이벤트
    /// 로그인 버튼 이벤트
    @objc private func loginButtonTapped() {
        // 로그인 로직 추가
    }
    
    /// 하단 페이지 컨트롤 스택 이미지 이벤트
    @objc private func imageTapped(_ sender: UITapGestureRecognizer) {
        if let index = sender.view?.tag {
            let offset = CGFloat(index) * scrollView.frame.size.width
            scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
            updatePageImages(for: index)
        }
    }
    
    // MARK: - StackView, scrollView 이미지 추가 메서드
    /// pageControlStackView 이미지 추가
    private func addImageToStackView() {
        for index in 0..<onboardingImages.count {
            let imageView = UIImageView().then {
                $0.contentMode = .center
                $0.clipsToBounds = true
                $0.snp.makeConstraints { make in
                    make.width.height.equalTo(16)
                }
                $0.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                $0.addGestureRecognizer(tapGesture)
                $0.tag = index
            }
            pageControlStackView.addArrangedSubview(imageView)
        }
        updatePageImages(for: 0)
    }
    
    /// pageControlStackView 이미지 업데이트
    private func updatePageImages(for pageIndex: Int) {
        for (index, view) in pageControlStackView.arrangedSubviews.enumerated() {
            if let imageView = view as? UIImageView {
                if index == pageIndex {
                    imageView.image = UIImage(named: "shineOnboarding")
                } else {
                    imageView.image = UIImage(systemName: "circle.fill")?.withTintColor(.gray600).resizeImage(9, 9)
                }
            }
        }
    }
    
    /// scrollView Image 추가
    func addImageToScrollView() {
        var xOffset: CGFloat = 0
        let scrollViewWidth = scrollView.bounds.width
        let scrollViewHeight = scrollView.bounds.height
        
        for image in onboardingImages {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: xOffset, y: 0, width: scrollViewWidth, height: scrollViewHeight)
            scrollView.addSubview(imageView)
            xOffset += scrollViewWidth
        }
        scrollView.contentSize = CGSize(width: xOffset, height: scrollViewHeight)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addImageToScrollView()
    }
}

// MARK: - UIScrollViewDelegate
extension LoginViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        updatePageImages(for: pageIndex)
    }
}



