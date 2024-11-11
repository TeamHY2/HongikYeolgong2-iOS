
import SwiftUI
import Combine


enum WeekDayEng: String, CaseIterable {
    case sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Wed = "Wed"
    case Thu = "Thu"
    case Fri = "Fri"
    case Sat = "Sat"
}

enum MoveType {
    case current
    case next
    case prev
}

struct CaledarView: View {
    @Environment(\.injected.interactors.calendarDataInteractor) var calendarDataInteractor
    @State private var AllStudy = [AllStudyRecord]()
    @State var seletedDate = Date()
    @State var currentMonth = [Day]()
    private let calendar = Calendar.current
    
    
    private let columns = [GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            // header
            HStack(spacing: 0) {
                Text(seletedDate.getMonthString())
                    .font(.suite(size: 24, weight: .bold))
                    .foregroundStyle(Color.gray100)
                
                
                Spacer().frame(width: 8.adjustToScreenWidth)
                
                Text(seletedDate.getYearString())
                    .font(.suite(size: 24, weight: .bold))
                    .foregroundStyle(Color.gray100)
                
                Spacer()
                HStack {
                    Button(action: {
                        changeMonth(.prev)
                    }) {
                        Image(.icCalendarLeft)
                    }
                    
                    Spacer().frame(width: 7.adjustToScreenWidth)
                    
                    Button(action: {
                        changeMonth(.next)
                    }) {
                        Image(.icCalendarRight)
                    }
                }
            }
            
            Spacer().frame(height: 12.adjustToScreenHeight)
            
            // weakday
            HStack(alignment: .center) {
                ForEach(WeekDayEng.allCases, id: \.rawValue) {
                    Text($0.rawValue)
                        .font(.suite(size: 12, weight: .medium))
                        .foregroundStyle(Color.gray300)
                        .frame(maxWidth: .infinity)
                }
            }
            
            Spacer().frame(height: 8.adjustToScreenHeight)
            
//             seleteMonth가 변경될때마다 makeMonth의 값을 받아서 currentMonth에 업데이트
            LazyVGrid(columns: columns, spacing: 5.adjustToScreenWidth) {
                ForEach(currentMonth, id: \.id) {
                    CalendarCell(dayInfo: $0)
                }
            }
            
            Spacer()
        }
        .onAppear {
            calendarDataInteractor.getAllStudy(studyRecords: $AllStudy)
            currentMonth = makeMonth(date: seletedDate, roomUsageInfo: AllStudy)
        }
        .onChange(of: AllStudy) { newAllStudy in
            currentMonth = makeMonth(date: seletedDate, roomUsageInfo: newAllStudy)
        }
    }
}

extension CaledarView {
    
    // 현재보다 1달뒤에 날짜정보를 반환한다.
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    // 현재보다 1달전에 날짜정보를 반환한다.
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    // 현재달에 몇일있는지를 반환한다.
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    // 현재달의 첫번째 달을 반환
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    // 무슨 요일인지 반환
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func makeMonth(date: Date, roomUsageInfo: [AllStudyRecord]) -> [Day] {
        var days: [Day] = []
        var count: Int = 1
        
        let daysInMonth = daysInMonth(date: date)
        let firstDayOfMonth = firstOfMonth(date: date)
        let startingSpace = weekDay(date: firstDayOfMonth)
        
        while(count <= 42) {
            // 이번달이 아닌경우 공백 처리
            if (count <= startingSpace || count - startingSpace > daysInMonth) {
                days.append(Day(dayOfNumber: ""))
            }
            
            else {
                let numberOfDay = count - startingSpace
                
                guard calendar.date(byAdding: .day, value: numberOfDay - 1, to: firstOfMonth(date: date)) != nil else {
                    return []
                }
                // 현재날짜 생성
                var components = calendar.dateComponents([.year, .month, .day], from: date)
                components.day = numberOfDay
                
                // 현재날짜와 서버에서 받아온 데이터의 날짜가 일치하는지 확인
                if let currentDay = calendar.date(from: components) {
                    let matchData = roomUsageInfo.filter { calendar.isDate($0.date, inSameDayAs: currentDay)}
                    days.append(Day(dayOfNumber: "\(numberOfDay)", usageRecord: matchData))
                } else {
                    // 일치하는 데이터가 존재하지 않는경우
                    days.append(Day(dayOfNumber: "\(numberOfDay)"))
                }
            }
            count += 1
        }
        return days
    }
    
    func changeMonth(_ moveType: MoveType) {
        var currentDate: Date!
        
        switch moveType {
        case .current:
            currentDate = Date()
        case .next:
            currentDate = plusMonth(date: seletedDate)
        case .prev:
            currentDate = minusMonth(date: seletedDate)
        }
        
        // 현재보다 더 미래의 월이 선택된 경우
        let maximumDateValidate = calendar.compare(currentDate, to: Date(), toGranularity: .month)
        
        // 날짜이동 최소값 날짜생성
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        let minimumDate = formatter.date(from: "2021/01")!
        let mimumDateValidate = calendar.compare(currentDate, to: minimumDate, toGranularity: .month)
        
        guard maximumDateValidate != .orderedDescending,
              mimumDateValidate != .orderedAscending else {
            return
        }
        
        seletedDate = currentDate
        
        currentMonth = makeMonth(date: seletedDate, roomUsageInfo: AllStudy)
    }

}


