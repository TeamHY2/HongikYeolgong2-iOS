//
//  AppleLoginButton.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/20/25.
//

import UIKit
import Then
import SnapKit

class AppleLoginButton: UIButton {
    private let appleImageView = UIImageView().then {
        $0.image = UIImage(systemName: "applelogo")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        $0.contentMode = .scaleAspectFit
        $0.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
    }
    
    private let title = UILabel().then {
        $0.text = "Apple로 계속하기"
        $0.textColor = .black
        $0.font = .pretendard(size: 16, weight: .semibold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        backgroundColor = .white
        
        [appleImageView, title].forEach { addSubview($0) }
        
        appleImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
