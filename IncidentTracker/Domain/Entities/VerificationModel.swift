//
//  VerificationModel.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - VerifyOtpResponse

struct VerificationModel: Equatable {
    let token: String?
    let roles: [Int]?

    init(token: String?, roles: [Int]?) {
        self.token = token
        self.roles = roles
    }
}
