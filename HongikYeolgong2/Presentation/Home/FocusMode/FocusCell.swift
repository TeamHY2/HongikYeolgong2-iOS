//
//  FocusCell.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 6/16/25.
//

import SwiftUI

struct FocusCell: View {
    var studyStatusInfo: StudyStatusInfo
    // UI 출력 계산 용도
    @State private var duration: TimeInterval = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            Image(studyStatusInfo.studyStatus ? .lampBlue : .lampGray)
            Text(studyStatusInfo.userName)
                .font(.suite(size: 14, weight: .medium))
                .foregroundStyle(.gray300)
            Text(formatTime(duration))
                .font(.suite(size: 14, weight: .medium))
                .foregroundStyle(.gray300)
        }
        .onAppear {
            duration = parseTime(from: studyStatusInfo.studyDuration)

            if studyStatusInfo.studyStatus {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    duration += 1
                }
            }
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }
    
    /// String -> TimeIntervar 형태로 변환 (시간 계산 용도)
    private func parseTime(from string: String) -> TimeInterval {
        let components = string.split(separator: ":").compactMap { Int($0) }
        guard components.count == 3 else { return 0 }
        return TimeInterval(components[0] * 3600 + components[1] * 60 + components[2])
    }
    /// TimeIntervar -> String 형태로 변환 (UI 출력 용도)
    private func formatTime(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}
