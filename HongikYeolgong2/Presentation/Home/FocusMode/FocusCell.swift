//
//  FocusCell.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 6/16/25.
//

import SwiftUI

struct FocusCell: View {
    var studyStatusInfo: StudyStatusInfo
    
    var body: some View {
        VStack {
            Image(studyStatusInfo.studyStatus ? .lampBlue : .lampGray)
            Text(studyStatusInfo.userName)
                .font(.suite(size: 14, weight: .medium))
                .foregroundStyle(.gray300)
            Text(studyStatusInfo.studyDuration)
                .font(.suite(size: 14, weight: .medium))
                .foregroundStyle(.gray300)
        }
    }
}
