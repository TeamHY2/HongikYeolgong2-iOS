
import SwiftUI

enum CellStyle: CaseIterable {
    case dayCount00
    case dayCount01
    case dayCount02
    case dayCount03
}

struct Day: Identifiable {
    var id = UUID().uuidString
    let dayOfNumber: String
    var usageRecord: [AllStudyRecord] = []
    
    var todayUsageCount: [Int] {
        return usageRecord.map {$0.studyCount}
    }
}

struct CalendarCell: View {
    
    let dayInfo: Day
    var isSelected: Bool
    var onTap: () -> Void
    
    private var cellStyle: CellStyle {
        let maxUsageCount = dayInfo.todayUsageCount.max() ?? 0
        
        if maxUsageCount >= 3 {
            return .dayCount03
        } else if maxUsageCount >= 2 {
            return .dayCount02
        } else if maxUsageCount >= 1 {
            return .dayCount01
        } else {
            return .dayCount00
        }
    }
    
    private var isVisible: Bool {
        dayInfo.dayOfNumber.isEmpty
    }
    
    var body: some View {
        Button {
            onTap()
        } label: {
            VStack {
                Text(dayInfo.dayOfNumber)
                    .font(.suite(size: 14, weight: .medium))
                    .foregroundStyle(getForegroundStyle())
            }
            .frame(width: 38.adjustToScreenWidth,height: 38.adjustToScreenHeight)
            .background(
                RoundedRectangle(cornerRadius: 10)
                            .fill(AngularGradient(gradient: Gradient(colors: getImageForCellStyle()), center: .center,startAngle: .degrees(-45), endAngle: .degrees(315)))
                            .frame(width: 38.adjustToScreenWidth,height: 38.adjustToScreenHeight)
            )
            .opacity(isVisible ? 0 : 1)
//            .overlay(isVisible || isSelected ? nil : Color.dark.opacity(0.8))
            .animation(.easeOut(duration: 0.12), value: isSelected)
        }
        .disabled(isVisible)
    }
    
    // 배경 색상 반환
    private func getImageForCellStyle() -> [Color] {
        switch cellStyle {
            case .dayCount00:
                return [.gray800.opacity(isSelected ? 1 : 0.3)]
            case .dayCount01:
                return [Color(.sRGB, red: 19/255, green: 30/255, blue: 72/255, opacity: isSelected ? 1 : 0.2),
                        Color(.sRGB, red: 25/255, green: 38/255, blue: 88/255, opacity: isSelected ? 1 : 0.2)]
            case .dayCount02:
                return [Color(.sRGB, red: 51/255, green: 79/255, blue: 178/255, opacity: isSelected ? 1 : 0.1),
                        Color(.sRGB, red: 83/255, green: 115/255, blue: 227/255, opacity: isSelected ? 1 : 0.1)]
            case .dayCount03:
                return [Color(.sRGB, red: 204/255, green: 246/255, blue: 48/255, opacity: isSelected ? 1 : 0.05),
                        Color(.sRGB, red: 244/255, green: 253/255, blue: 61/255, opacity: isSelected ? 1 : 0.05)]
        }
    }
    
    private func getForBorderStyle() -> Color {
        switch cellStyle {
            case .dayCount00:
                return .gray800
            case .dayCount01:
                return .blue400
            case .dayCount02:
                return .blue200
            case .dayCount03:
                return Color(.sRGB, red: 206/255, green: 207/255, blue: 55/255, opacity: 1)
        }
    }
    
    private func getImageForCellStyle() -> ImageResource {
        switch cellStyle {
            case .dayCount00: return .dayCount00
            case .dayCount01: return .dayCount01
            case .dayCount02: return .dayCount02
            case .dayCount03: return .dayCount03
        }
    }
    
    private func getForegroundStyle() -> Color {
        switch cellStyle {
            case .dayCount00: return .gray300.opacity(isSelected ? 1 : 0.3)
            case .dayCount01: return .gray100.opacity(isSelected ? 1 : 0.3)
            case .dayCount02: return .white.opacity(isSelected ? 1 : 0.3)
            case .dayCount03: return .gray600.opacity(isSelected ? 1 : 0.3)
        }
    }
}

