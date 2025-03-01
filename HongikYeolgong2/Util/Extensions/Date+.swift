
import Foundation

extension Date {
    func getHourMinutes() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let hour12 = hour % 12 == 0 ? 12 : hour % 12
        
        return String(format: "%02d", hour12) + ":" + String(format: "%02d", minutes)
    }
    
    func getDaypart() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let daypart = hour < 12 ? "AM" : "PM"
        return daypart
    }
    
    func dateToISO8601() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let ISO8601String = formatter.string(from: self)
        
        return ISO8601String
    }
    
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: self)
        return dateString
    }
    
    func getMonthString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLL"
        return dateFormatter.string(from: self)
    }
    
    func getYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
    
    func getDayOffset() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday! - 1
    }
    
    func formattedFullDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    
    func formattedMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M"
        return formatter.string(from: self)
    }
    
    func formattedDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
}
