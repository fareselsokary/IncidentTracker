//
//  String.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - String Email Validation

extension String {
    /// Validates whether the string is a properly formatted email address.
    ///
    /// This check uses a lightweight regular expression that covers
    /// most real-world cases:
    /// - Local part: letters, numbers, dot, underscore, percent, plus, hyphen
    /// - "@" symbol separating local part and domain
    /// - Domain: letters, numbers, dots, and hyphens
    /// - Top-level domain: at least 2 alphabetic characters
    ///
    /// ⚠️ Note:
    /// - This is not a full RFC 5322 compliance check, but it’s safe and
    ///   fast for typical app-level email validation.
    /// - For stricter validation, consider using `NSDataDetector` with
    ///   `.link` type and filtering results with `mailto:`.
    ///
    /// Example:
    /// ```swift
    /// "fares@example.com".isValidEmail  // true
    /// "not-an-email".isValidEmail      // false
    /// ```
    var isValidEmail: Bool {
        // Regex pattern
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

        // Evaluate string against regex
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
}
