//
//  SizeCheckModifier.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/4/24.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct SizeCheckModifier: ViewModifier {
    @Binding private var size: CGSize
    @State private var hasCheckedSize = false
    
    init(size: Binding<CGSize>) {
        self._size = size
    }
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { g in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: g.size)
            })
            .onPreferenceChange(SizePreferenceKey.self, perform: { newSize in
                if !hasCheckedSize {
                    size = newSize
                    hasCheckedSize = true
                }
            })
    }
}

extension View {
    func checkSize(in size: Binding<CGSize>) -> some View {
        return modifier(SizeCheckModifier(size: size))
    }
}
