//
//  RecordView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        VStack(spacing: 13.adjustToScreenHeight) {
            Spacer()
            // 기록 정보 출력부분
            HStack(spacing: 13.adjustToScreenWidth) {
                RecordCell(title: "연간", hours: 200, minutes: 4)
                RecordCell(title: "이번학기", hours: 120, minutes: 4)
            }
            HStack(spacing: 13.adjustToScreenWidth) {
                RecordCell(title: "월간", hours: 50, minutes: 4)
                RecordCell(title: "투데이", hours: 3, minutes: 24)
            }
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 36)
    }
}

#Preview {
    RecordView()
}
