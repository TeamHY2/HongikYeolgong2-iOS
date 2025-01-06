//
//  DepartmentInputView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/6/25.
//

import SwiftUI

struct DepartmentInputView: View {
    @Binding var searchDepartment: String
    @FocusState var isFocused: Bool
    let departments: [Department]
    let selectedDepartment: (Department) -> Void
    
    var body: some View {
        HStack {
            TextField(
                "학과를 입력해주세요",
                text: $searchDepartment
            )
            .focused($isFocused)
            .foregroundColor(.gray200)
            .padding(.leading, 16)
            .padding(.trailing, 8)
            Image(.close)
                .padding(.trailing, 14)
                .onTapGesture {
                    searchDepartment = ""
                }
                .opacity(!searchDepartment.isEmpty && isFocused ? 1 : 0)
        }
        .frame(maxHeight: 48.adjustToScreenHeight)
        .background(.gray800)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray400)
                .opacity(isFocused ? 1 : 0)
        )
        
        if !searchDepartment.isEmpty {
            let filteredDepartments = departments.filter { $0.rawValue.contains(searchDepartment) }
            let maxHeight = CGFloat(min(filteredDepartments.count, 3)) * 45
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(filteredDepartments, id: \.self) { department in
                        Button(action: {
                            selectedDepartment(department)
                        }) {
                            Text(department.rawValue)
                                .font(.pretendard(size: 16, weight: .regular))
                                .foregroundStyle(.gray200)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(12)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: maxHeight)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gray800)
            )
        }
    }
}
