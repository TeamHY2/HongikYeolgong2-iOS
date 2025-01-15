//
//  SubmitButton.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/15/24.
//

import SwiftUI

struct SubmitButton: View {
    let isEdit: Bool
    let action: () -> Void
    let disabled: Bool
    
    var body: some View {
        Button(action: action) {
            Image(isEdit ? .editButtonEnable : .submitButtonEnable)
                .resizable()
                .frame(height: 50.adjustToScreenHeight)
        }
        .disabled(disabled)
        .overlay(disabled ? Color.dark.opacity(0.6) : nil)
    }
}
