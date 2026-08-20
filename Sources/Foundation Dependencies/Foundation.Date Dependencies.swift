// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-foundation-dependencies open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-foundation-dependencies
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// The ambient-calendar `Date` API.
//
// `Foundation Date Extensions` owns the date logic and takes its calendar
// explicitly, which keeps that package free of package dependencies. Every
// member below resolves `\.calendar` from the dependency environment and
// forwards to its calendar-parameterized counterpart, so the ergonomic
// zero-argument spelling stays available and stays injectable.

import Dependencies
import Foundation
import Foundation_Date_Extensions

// MARK: - Date Creation

extension Date {
    /// Creates a new Date with the specified components, validating their validity,
    /// using the calendar from the dependency environment.
    ///
    /// - Returns: A new `Date` instance if the components are valid, `nil` otherwise
    ///
    /// ## Example
    /// ```swift
    /// let validDate = Date(year: 2025, month: 7, day: 26)
    /// let invalidDate = Date(year: 2025, month: 2, day: 30) // Returns nil
    /// ```
    public init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) {
        @Dependency(\.calendar) var calendar
        self.init(
            year: year,
            month: month,
            day: day,
            hour: hour,
            minute: minute,
            second: second,
            in: calendar
        )
    }
}

// MARK: - Date Arithmetic

/// Adds date components to a date, using the calendar from the dependency environment.
///
/// ## Example
/// ```swift
/// let tomorrow = Date() + 1.day
/// let complex = Date() + 1.year + 6.months + 2.days
/// ```
///
/// - Warning: This operator force-unwraps the result. Use `adding(_:)` for safe arithmetic.
public func + (lhs: Date, rhs: DateComponents) -> Date {
    @Dependency(\.calendar) var calendar
    return lhs.adding(rhs, in: calendar)!
}

/// Subtracts date components from a date, using the calendar from the dependency environment.
///
/// ## Example
/// ```swift
/// let yesterday = Date() - 1.day
/// ```
///
/// - Warning: This operator force-unwraps the result. Use `subtracting(_:)` for safe arithmetic.
public func - (lhs: Date, rhs: DateComponents) -> Date {
    @Dependency(\.calendar) var calendar
    return lhs.subtracting(rhs, in: calendar)!
}

// MARK: - Safe Date Arithmetic

extension Date {
    /// Safely adds date components to this date.
    public func adding(_ components: DateComponents) -> Date? {
        @Dependency(\.calendar) var calendar
        return adding(components, in: calendar)
    }

    /// Safely subtracts date components from this date.
    public func subtracting(_ components: DateComponents) -> Date? {
        @Dependency(\.calendar) var calendar
        return subtracting(components, in: calendar)
    }
}

// MARK: - Date Comparisons

extension Date {
    /// Determines if this date is on the same day as the specified date.
    public func isSameDay(as date: Date) -> Bool {
        @Dependency(\.calendar) var calendar
        return isSameDay(as: date, in: calendar)
    }

    /// Determines if this date is today.
    public var isToday: Bool {
        @Dependency(\.calendar) var calendar
        return isToday(in: calendar)
    }

    /// Determines if this date is tomorrow.
    public var isTomorrow: Bool {
        @Dependency(\.calendar) var calendar
        return isTomorrow(in: calendar)
    }

    /// Determines if this date was yesterday.
    public var isYesterday: Bool {
        @Dependency(\.calendar) var calendar
        return isYesterday(in: calendar)
    }

    /// Determines if this date is in the current week.
    public var isThisWeek: Bool {
        @Dependency(\.calendar) var calendar
        return isThisWeek(in: calendar)
    }

    /// Determines if this date is in the current month.
    public var isThisMonth: Bool {
        @Dependency(\.calendar) var calendar
        return isThisMonth(in: calendar)
    }

    /// Determines if this date is in the current year.
    public var isThisYear: Bool {
        @Dependency(\.calendar) var calendar
        return isThisYear(in: calendar)
    }
}

// MARK: - Date Component Access

extension Date {
    /// The era component of this date.
    public var era: Int {
        @Dependency(\.calendar) var calendar
        return era(in: calendar)
    }

    /// The year component of this date.
    public var year: Int {
        @Dependency(\.calendar) var calendar
        return year(in: calendar)
    }

    /// The month component of this date.
    public var month: Int {
        @Dependency(\.calendar) var calendar
        return month(in: calendar)
    }

    /// The day component of this date.
    public var day: Int {
        @Dependency(\.calendar) var calendar
        return day(in: calendar)
    }

    /// The hour component of this date.
    public var hour: Int {
        @Dependency(\.calendar) var calendar
        return hour(in: calendar)
    }

    /// The minute component of this date.
    public var minute: Int {
        @Dependency(\.calendar) var calendar
        return minute(in: calendar)
    }

    /// The second component of this date.
    public var second: Int {
        @Dependency(\.calendar) var calendar
        return second(in: calendar)
    }

    /// The weekday component of this date.
    public var weekday: Int {
        @Dependency(\.calendar) var calendar
        return weekday(in: calendar)
    }

    /// The weekday-ordinal component of this date.
    public var weekdayOrdinal: Int {
        @Dependency(\.calendar) var calendar
        return weekdayOrdinal(in: calendar)
    }

    /// The quarter component of this date.
    public var quarter: Int {
        @Dependency(\.calendar) var calendar
        return quarter(in: calendar)
    }

    /// The week-of-month component of this date.
    public var weekOfMonth: Int {
        @Dependency(\.calendar) var calendar
        return weekOfMonth(in: calendar)
    }

    /// The week-of-year component of this date.
    public var weekOfYear: Int {
        @Dependency(\.calendar) var calendar
        return weekOfYear(in: calendar)
    }

    /// The year-for-week-of-year component of this date.
    public var yearForWeekOfYear: Int {
        @Dependency(\.calendar) var calendar
        return yearForWeekOfYear(in: calendar)
    }

    /// The nanosecond component of this date.
    public var nanosecond: Int {
        @Dependency(\.calendar) var calendar
        return nanosecond(in: calendar)
    }

    /// The identifier of the calendar in the dependency environment.
    public var calendarIdentifier: Calendar.Identifier {
        @Dependency(\.calendar) var calendar
        return calendar.identifier
    }

    /// The time zone of the calendar in the dependency environment.
    public var timeZone: TimeZone {
        @Dependency(\.calendar) var calendar
        return calendar.timeZone
    }

    /// Whether the month containing this date is a leap month.
    @available(macOS 14, iOS 17, tvOS 17, watchOS 10, *)
    public var isLeapMonth: Int {
        @Dependency(\.calendar) var calendar
        return isLeapMonth(in: calendar)
    }

    /// The day-of-year component of this date.
    @available(macOS 15, iOS 18, tvOS 18, watchOS 11, *)
    public var dayOfYear: Int {
        @Dependency(\.calendar) var calendar
        return dayOfYear(in: calendar)
    }
}

// MARK: - Weekends and Workdays

extension Date {
    /// Whether this date falls on a weekend.
    public var isWeekend: Bool {
        @Dependency(\.calendar) var calendar
        return isWeekend(in: calendar)
    }

    /// The next date that does not fall on a weekend.
    public var nextWeekday: Date {
        @Dependency(\.calendar) var calendar
        return nextWeekday(in: calendar)
    }

    /// This date, advanced to the next workday if it falls on a weekend.
    public func ifWeekendThenNextWorkday() -> Date {
        @Dependency(\.calendar) var calendar
        return ifWeekendThenNextWorkday(in: calendar)
    }

    /// This date, moved back to the previous workday if it falls on a weekend.
    public func ifWeekendThenPreviousWorkday() -> Date {
        @Dependency(\.calendar) var calendar
        return ifWeekendThenPreviousWorkday(in: calendar)
    }
}

// MARK: - Weekday Navigation

extension Date {
    /// Returns the next occurrence of the given weekday, or `nil` if `weekday`
    /// is outside the valid range `1...7`.
    public func next(_ weekday: Int) -> Date? {
        @Dependency(\.calendar) var calendar
        return next(weekday, in: calendar)
    }

    /// Returns the previous occurrence of the given weekday, or `nil` if
    /// `weekday` is outside the valid range `1...7`.
    public func previous(_ weekday: Int) -> Date? {
        @Dependency(\.calendar) var calendar
        return previous(weekday, in: calendar)
    }
}

// MARK: - Day Spans

extension Date {
    /// The number of whole days between this date and another.
    public func daysBetween(_ date: Date) -> Int {
        @Dependency(\.calendar) var calendar
        return daysBetween(date, in: calendar)
    }

    /// This date advanced by a number of business days, skipping weekends.
    public func addingBusinessDays(_ businessDays: Int) -> Date {
        @Dependency(\.calendar) var calendar
        return addingBusinessDays(businessDays, in: calendar)
    }
}

// MARK: - Period Boundaries

extension Date {
    /// The first day of the month containing this date.
    public var firstDayOfMonth: Date {
        @Dependency(\.calendar) var calendar
        return firstDayOfMonth(in: calendar)
    }

    /// The last day of the month containing this date.
    public var lastDayOfMonth: Date {
        @Dependency(\.calendar) var calendar
        return lastDayOfMonth(in: calendar)
    }

    /// The first instant of the day containing this date.
    public var startOfDay: Date {
        @Dependency(\.calendar) var calendar
        return startOfDay(in: calendar)
    }

    /// The last second of the day containing this date.
    public var endOfDay: Date {
        @Dependency(\.calendar) var calendar
        return endOfDay(in: calendar)
    }

    /// The first instant of the week containing this date.
    public var startOfWeek: Date {
        @Dependency(\.calendar) var calendar
        return startOfWeek(in: calendar)
    }

    /// The last second of the week containing this date.
    public var endOfWeek: Date {
        @Dependency(\.calendar) var calendar
        return endOfWeek(in: calendar)
    }

    /// The first instant of the month containing this date.
    public var startOfMonth: Date {
        @Dependency(\.calendar) var calendar
        return startOfMonth(in: calendar)
    }

    /// The last second of the month containing this date.
    public var endOfMonth: Date {
        @Dependency(\.calendar) var calendar
        return endOfMonth(in: calendar)
    }

    /// The first instant of the year containing this date.
    public var startOfYear: Date {
        @Dependency(\.calendar) var calendar
        return startOfYear(in: calendar)
    }

    /// The last second of the year containing this date.
    public var endOfYear: Date {
        @Dependency(\.calendar) var calendar
        return endOfYear(in: calendar)
    }
}

// MARK: - Relative Description

extension Date {
    /// The whole number of years between this date and a reference date.
    public func age(at referenceDate: Date = Date()) -> Int {
        @Dependency(\.calendar) var calendar
        return age(at: referenceDate, in: calendar)
    }

    /// A human-readable description of how long ago this date was.
    public func timeAgoSince(_ date: Date = Date()) -> String {
        @Dependency(\.calendar) var calendar
        return timeAgoSince(date, in: calendar)
    }

    /// A human-readable description of how far in the future this date is.
    public func timeUntil(_ date: Date = Date()) -> String {
        @Dependency(\.calendar) var calendar
        return timeUntil(date, in: calendar)
    }

    /// A short relative description of this date, such as `"yesterday"` or `"in 2 hours"`.
    public var relativeFormatted: String {
        @Dependency(\.calendar) var calendar
        return relativeFormatted(in: calendar)
    }
}
