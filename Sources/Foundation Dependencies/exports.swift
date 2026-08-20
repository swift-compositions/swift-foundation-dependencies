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

// Re-exports both halves of the integration so `import Foundation_Dependencies`
// is a self-contained surface: the pure, calendar-parameterized date vocabulary
// and the dependency system both appear in the vended API.

@_exported import Dependencies
@_exported import Foundation_Date_Extensions
