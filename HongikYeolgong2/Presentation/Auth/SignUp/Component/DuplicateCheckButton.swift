//
//  DuplicateCheckButton.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/15/24.
//

import SwiftUI

struct DuplicateCheckButton: View {
    let action: () -> Void
    let disabled: Bool
    
    var body: some View {
        Button(action: action, label: {
            Text("중복확인")
                .foregroundStyle(disabled ? Color.gray200 : Color.white)
                .frame(maxWidth: 88.adjustToScreenWidth, maxHeight: 48.adjustToScreenHeight)
        })
        .background(disabled ? Color.blue400 : Color.blue100)
        .disabled(disabled)
        .cornerRadius(8)
    }
}

#Preview {
    DuplicateCheckButton(action: {}, disabled: false)
}
