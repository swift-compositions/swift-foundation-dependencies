# swift-foundation-dependencies

The calendar as a dependency value, and the ambient-calendar date API built on it, for [swift-dependencies](https://github.com/swift-compositions/swift-dependencies).

> The foundation-extensions × dependencies integration package. All date logic
> lives in [swift-foundation-extensions](https://github.com/swift-molecules/swift-foundation-extensions),
> which carries no package dependencies at all; this package supplies the
> calendar and the zero-argument spelling that reads it.

## Overview

`import Foundation_Dependencies` provides two things:

1. **`@Dependency(\.calendar)`** — a `Calendar` resolved through the standard
   dependency chain.
2. **The ambient-calendar date API** — `date.isToday`, `date.startOfMonth`,
   `date + 1.day` and friends, each resolving `\.calendar` and forwarding to its
   calendar-parameterized counterpart in `Foundation Date Extensions`.

| Context | Resolves to | Behavior |
|---------|-------------|----------|
| Live    | `Calendar.autoupdatingCurrent` | the current system calendar |
| Preview | chains to `liveValue` | the current system calendar |
| Test    | chains to `liveValue` | override explicitly for determinism |

Institute `swift-dependencies` does not vend built-in environment keys, so the
`\.calendar` key is defined here, reproducing pointfree's `liveValue` semantics.

## Which package do I want?

| You want | Import | Package dependencies |
|----------|--------|----------------------|
| Pure date operations, calendar passed explicitly | `Foundation_Date_Extensions` | none |
| The zero-argument spelling and `\.calendar` | `Foundation_Dependencies` | `swift-dependencies` |

```swift
// Explicit — no package dependencies, fully deterministic.
import Foundation_Date_Extensions
date.startOfMonth(in: calendar)

// Ambient — the calendar comes from the dependency environment.
import Foundation_Dependencies
date.startOfMonth
```

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-compositions/swift-foundation-dependencies.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Foundation Dependencies", package: "swift-foundation-dependencies")
    ]
)
```

## Quick Start

```swift
import Foundation_Dependencies

let date = Date(year: 2025, month: 7, day: 26)!

// Component access
date.year        // 2025
date.month       // 7
date.weekday     // 7 (Saturday)

// Arithmetic
let tomorrow = date + 1.day
let complex = date + 1.year + 6.months + 2.days

// Boundaries
date.startOfDay
date.endOfMonth
date.startOfYear

// State
date.isToday
date.isWeekend

// Spans and relative description
date.daysBetween(tomorrow)
date.addingBusinessDays(3)
date.relativeFormatted
```

## Overriding the calendar

Every member above reads `\.calendar`, so a single override redirects the whole
API — this is the capability the explicit form cannot offer:

```swift
withDependencies {
    $0.calendar = Calendar(identifier: .gregorian)
} operation: {
    report.start = date.startOfMonth
    report.days = date.daysBetween(other)
}
```

In tests:

```swift
@Suite(.dependency(\.calendar, Calendar(identifier: .gregorian)))
struct Report { ... }
```

## License

Licensed under the [Apache License, Version 2.0](LICENSE.md).
