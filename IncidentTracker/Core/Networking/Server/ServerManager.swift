//
//  Server.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

final class ServerManager {
    static let shared = ServerManager()

    private init() {}

    private(set) var baseURL: String = ""
    private var _headers: [String: String] = [:]

    var headers: [String: String] {
        _headers
    }

    func configure(baseURL: String, headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self._headers = headers
    }

    func updateAuthorizationToken(_ token: String?) {
        if let token {
            _headers["Authorization"] = "Bearer \(token)"
        } else {
            _headers.removeValue(forKey: "Authorization")
        }
    }
}
