//
//  Date+Extension.swift
//  
//
//  Created by Azizbek Asadov on 07/01/23.
//

extension Date {
    public var isToday: Bool {
        return self.isInSameDayOf(date: Date())
    }

    public func isInSameDayOf(date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
}

extension Date {
    // Without milliseconds
    public var timestamp: Int {
        return Int((self.timeIntervalSince1970).rounded())
    }

    // With milliseconds
    public var timestampWithMilliseconds: Double {
        return Double(self.timeIntervalSince1970)
    }

    /// For string values of type 2019-11-14T09:31:38.123005Z
    public var ISO8601String: String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.string(from: self)
    }
}

extension Date {
    public var year: Int {
        let calendar = Calendar.current
        return calendar.component(.year, from: self)
    }

    public var month: Int {
        let calendar = Calendar.current
        return calendar.component(.month, from: self)
    }

    public var day: Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
}

extension Date {
    /// Returns the amount of years from another date
    public func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    public func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    public func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    public func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    public func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    public func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    public func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the amount of nanoseconds from another date
    public func nanoseconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    /// Returns the a custom time interval description from another date
    public func offset(from date: Date) -> String {
        if years(from: date) > 0 {
            return "\(years(from: date))y"
        }
        if months(from: date) > 0 {
            return "\(months(from: date))M"
        }
        if weeks(from: date) > 0 {
            return "\(weeks(from: date))w"
        }
        if days(from: date) > 0 {
            return "\(days(from: date))d"
        }
        if hours(from: date) > 0 {
            return "\(hours(from: date))h"
        }
        if minutes(from: date) > 0 {
            return "\(minutes(from: date))m"
        }
        if seconds(from: date) > 0 {
            return "\(seconds(from: date))s"
        }
        if nanoseconds(from: date) > 0 {
            return "\(nanoseconds(from: date))ns"
        }
        return ""
    }
}
