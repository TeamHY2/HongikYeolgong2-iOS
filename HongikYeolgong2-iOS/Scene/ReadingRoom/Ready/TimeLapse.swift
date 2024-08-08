//
//  TimeLapse.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/8/24.
//

import SwiftUI

struct TimeLapse: View {
    
    let startTime: Date
    let endTime: Date
    let timeRemaining: Double
    let usageCount: Int
//    let totalTime: Double
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(alignment: .center) {
                        CustomText(font: .suite, title: "Start", textColor: .customGray300, textWeight: .medium, textSize: 12)
                        
                        Image(.arrow)
                            .offset(y: -4)
                    }
                    
                    Spacer()
                        .frame(height: UIScreen.UIHeight(11))
                    
                    HStack(alignment: .firstTextBaseline)  {
                        CustomText(font: .suite, title: startTime.getHourMinutes(), textColor: .customGray100, textWeight: .extrabold, textSize: 30)
                        CustomText(font: .suite, title: startTime.getDaypart(), textColor: .customGray100, textWeight: .medium, textSize: 14)
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        CustomText(font: .suite, title: "End", textColor: .customGray300, textWeight: .medium, textSize: 12)
                        
                        Image(.arrow)
                            .offset(y: -4)
                            .opacity(0)
                    }
                    
                    Spacer()
                        .frame(height: UIScreen.UIHeight(11))
                    
                    HStack(alignment: .firstTextBaseline) {
                        CustomText(font: .suite, title: endTime.getHourMinutes(), textColor: .customGray100, textWeight: .extrabold, textSize: 30)
                        CustomText(font: .suite, title: endTime.getDaypart(), textColor: .customGray100, textWeight: .medium, textSize: 14)
                    }
                }
                
                Spacer()
            }
            
            Spacer()
                .frame(height: UIScreen.UIHeight(32))
            
            // 남은 시간
            HStack {
                CustomText(font: .suite, title: "Time Left", textColor: .customGray300, textWeight: .medium, textSize: 12)
                Spacer()
            }
            
            Spacer()
                .frame(height: UIScreen.UIHeight(11))
            
            HStack {
                CustomText(font: .suite, title: timeRemaining.getFullTimeString(), textColor: timeRemaining <= (30) ? .customYellow100 : .customGray100, textWeight: .extrabold, textSize: 30)
                
                Spacer()
                
                HStack {
//                    Image(totalTime >= Constants.StudyRoomService.starRatingCount00 ? .shineCount01 : .shineCount00)
//                    Image(totalTime >= Constants.StudyRoomService.starRatingCount01 ? .shineCount02 : .shineCount00)
//                    Image(totalTime >= Constants.StudyRoomService.starRatingCount02 ? .shineCount03 : .shineCount00)
                    Image(.shineCount01)
                    Image(usageCount >= 1 ? .shineCount02 : .shineCount00)
                    Image(usageCount >= 2 ? .shineCount03 : .shineCount00)
                }
            }
        }
    }
}

extension Double {
    func getFullTimeString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        let formattedString = formatter.string(from: TimeInterval(self))!
        return formattedString
    }
    
}

#Preview {
    TimeLapse(startTime: Date(), endTime: Date(), timeRemaining: 0, usageCount: 0)
}
