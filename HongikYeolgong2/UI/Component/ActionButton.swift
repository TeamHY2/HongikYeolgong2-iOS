//
//  ActionButton.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/25/24.
//

import SwiftUI

struct ActionButton: View {
   // MARK: - Properties
   let title: String
   let font: UIFont
   let width: CGFloat
   let height: CGFloat
   let backgroundColor: Color
   let foregroundColor: Color
   let radius: CGFloat
   let action: () -> Void
   
   // MARK: - Initializer
   init(
       title: String = "",
       font: UIFont = .suite(size: 16, weight: .semibold),
       height: CGFloat = 52,
       width: CGFloat = .infinity,
       backgroundColor: Color = .blue,
       foregroundColor: Color = .white,
       radius: CGFloat = 0,
       action: @escaping () -> Void
   ) {
       self.title = title
       self.font = font
       self.width = width
       self.height = height
       self.backgroundColor = backgroundColor
       self.foregroundColor = foregroundColor
       self.radius = radius
       self.action = action
   }
   
   // MARK: - Body
   var body: some View {
       Button(action: action) {
           Text(title)
               .frame(maxWidth: width, minHeight: height)
               .font(font)
               .foregroundStyle(foregroundColor)
               .background(backgroundColor)
               .cornerRadius(radius)
       }
   }
}

