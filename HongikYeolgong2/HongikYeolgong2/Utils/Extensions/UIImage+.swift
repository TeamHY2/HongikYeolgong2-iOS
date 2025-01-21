//
//  UIImage+.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/18/25.
//

import UIKit

extension UIImage {
    /// 이미지 사이즈 수정
    func resizeImage(_ width: Int, _ Height: Int) -> UIImage {
        let imageSize = CGSize(width: width, height: Height)
        
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: imageSize))
        }
    }
}
