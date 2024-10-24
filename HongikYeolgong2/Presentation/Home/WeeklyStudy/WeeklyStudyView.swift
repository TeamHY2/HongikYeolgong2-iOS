//
//  WeeklyStudy.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/5/24.
//

import SwiftUI

struct WeeklyStudyView: View {
    
    var body: some View {
        HStack {
            ForEach(1...7, id: \.self) { number in
               WeeklyStudyCell()
                if number != 7 {
                    Spacer()
                }
            }
        }        
    }
}
