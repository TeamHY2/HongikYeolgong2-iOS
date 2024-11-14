//
//  DropDownPicker.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/3/24.
//

import SwiftUI

struct DropDownPicker: View {
    @State private var contentSize: CGSize = .zero
    
    @Binding var text: String
    @Binding var seletedItem: String
    
    @FocusState var isFocused: Bool
    
    let placeholder: String
    let items: [String]
    
    private var filterdItem: [String] {
        items.filter { $0.contains(text)}
    }
    
    private var isEmpty: Bool {
        !text.isEmpty && !filterdItem.isEmpty
    }
    
    private var contentHeight: CGFloat {
        (contentSize.height + 1) * CGFloat(filterdItem.count)
    }
    
    private var maxHeight: CGFloat {
        (contentSize.height + 1) * 3
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 48)
                    .foregroundColor(.gray800)
                    .cornerRadius(8)
                
                HStack {
                    TextField(text: $text) {
                        Text(placeholder)
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundStyle(.gray400)
                    }
                    .focused($isFocused)
                    .foregroundColor(.gray200)
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                    
                    if !text.isEmpty {
                        Image(.close)
                            .padding(.trailing, 14)
                            .onTapGesture {
                                text = ""
                            }
                    }
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray400)
                    .opacity(isFocused ? 1 : 0)
            )
            
            // scrollView
            if (isFocused && isEmpty) || (isFocused && text.isEmpty) {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(isFocused && text.isEmpty ? items : filterdItem, id: \.self) { item in
                            Button(action: {
                                seletedItem = item
                                text = item
                                isFocused = false
                            }, label: {
                                Text("\(item)")
                                    .font(.pretendard(size: 16, weight: .regular))
                                    .foregroundStyle(.gray200)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(12)})
                            .checkSize(in: $contentSize)
                        }
                    }
                }
                .frame(maxHeight: !filterdItem.isEmpty ? min(contentHeight, maxHeight) : maxHeight)
                .background(.gray800)
                .cornerRadius(8)
                .layoutPriority(3)
            }
        }
    }
}
