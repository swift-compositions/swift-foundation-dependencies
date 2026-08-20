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

// The ambient-calendar `DateComponents` operators.
//
// Component arithmetic is calendar-relative, so the pure operations in
// `Foundation Date Extensions` take a calendar explicitly. An operator has
// nowhere to put that argument, so the operator spellings live here and read
// `\.calendar` from the dependency environment.

import Dependencies
import Foundation
import Foundation_Date_Extensions

// MARK: - DateComponents Arithmetic

extension DateComponents {
    /// Adds two DateComponents together, using the calendar from the dependency environment.
    ///
    /// ## Example
    /// ```swift
    /// let combined = 1.day + 2.hours + 30.minutes
    /// let result = Date() + combined
    /// ```
    public static func + (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
        @Dependency(\.calendar) var calendar
        return lhs.adding(rhs, in: calendar)
    }

    /// Subtracts the second DateComponents from the first, using the calendar from the
    /// dependency environment.
    ///
    /// ## Example
    /// ```swift
    /// let difference = 2.weeks - 3.days
    /// let result = Date() + difference // 11 days from now
    /// ```
    public static func - (lhs: DateComponents, rhs: DateComponents) -> DateComponents {
        @Dependency(\.calendar) var calendar
        return lhs.subtracting(rhs, in: calendar)
    }

    /// Multiplies DateComponents by an integer factor, using the calendar from the
    /// dependency environment.
    ///
    /// ## Example
    /// ```swift
    /// let threeDays = 1.day * 3
    /// let sixMonths = 1.month * 6
    /// ```
    public static func * (lhs: DateComponents, rhs: Int) -> DateComponents {
        @Dependency(\.calendar) var calendar
        return lhs.multiplied(by: rhs, in: calendar)
    }

    /// Multiplies DateComponents by an integer factor (commutative).
    ///
    /// ## Example
    /// ```swift
    /// let threeDays = 3 * 1.day
    /// let sixMonths = 6 * 1.month
    /// ```
    public static func * (lhs: Int, rhs: DateComponents) -> DateComponents {
        return rhs * lhs
    }
}
