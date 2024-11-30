//
//  Redacted.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/30/24.
//

import SwiftUI

private struct RedactedKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var isRedacted: Bool {
        get { self[RedactedKey.self] }
        set { self[RedactedKey.self] = newValue }
    }
}

struct RedactedContainer: ViewModifier {
    var isRedacted: Bool = true
    func body(content: Content) -> some View {
        content.environment(\.isRedacted, isRedacted)
    }
}

struct RedactedContent: ViewModifier {
    @Environment(\.isRedacted) private var isRedacted
    @State var opacity: Double = 0.2
    let color: Color = .gray400
    
    func body(content: Content) -> some View {
        content
            .opacity(isRedacted ? 0 : 1)
            .overlay(
                isRedacted ?  RoundedRectangle(cornerRadius: 8.0)
                    .fill(color.opacity(opacity))
                    .frame(maxWidth: .infinity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.75).repeatForever(autoreverses: true)) {
                            opacity = opacity >= 0.4 ? 0.2 : 0.4
                        }
                    } : nil
            )
    }
}

extension View {
    func redacted(isRedacted: Bool = true) -> some View {
        modifier(RedactedContainer(isRedacted: isRedacted))
    }
}

extension View {
    func redactedIfNeeded() -> some View {
        modifier(RedactedContent())
    }
}

