//
//  FocusCell.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 6/16/25.
//

import SwiftUI

struct FocusCell: View {
    var body: some View {
        VStack {
            Image(.lampGray)
            Text("홍익열공이")
                .font(.suite(size: 14, weight: .medium))
                .foregroundStyle(.gray300)
            Text("8:39:21")
                .font(.suite(size: 14, weight: .medium))
                .foregroundStyle(.gray300)
        }
    }
}

#Preview {
    FocusCell()
}
