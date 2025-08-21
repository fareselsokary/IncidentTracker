//
//  DashboardResponse.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

// MARK: - DashboardResponse

/// Represents the API response for the dashboard data.
/// Contains a base URL and a list of incidents.
struct DashboardResponse: Codable {
    /// The base URL for the dashboard API.
    let baseUrl: String?
    /// A list of dashboard incidents returned by the API.
    let incidents: [DashboardIncidentResponse]?

    init(baseUrl: String?, incidents: [DashboardIncidentResponse]?) {
        self.baseUrl = baseUrl
        self.incidents = incidents
    }

    enum CodingKeys: String, CodingKey {
        case baseUrl = "baseURL"
        case incidents
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseUrl = try container.decodeIfPresent(String.self, forKey: .baseUrl)
        incidents = try container.decodeIfPresent([DashboardIncidentResponse].self, forKey: .incidents)
    }
}

// MARK: - DashboardIncidentResponse

/// Represents a single incident in the dashboard API response.
struct DashboardIncidentResponse: Codable {
    /// Status code of the incident.
    let status: Int?
    /// Count information for the incident.
    let count: DashboardCountResponse?

    init(status: Int?, count: DashboardCountResponse?) {
        self.status = status
        self.count = count
    }

    enum CodingKeys: String, CodingKey {
        case status
        case count = "_count"
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
        count = try container.decodeIfPresent(DashboardCountResponse.self, forKey: .count)
    }
}

// MARK: - DashboardCountResponse

/// Represents the count object in the dashboard API response.
struct DashboardCountResponse: Codable {
    /// Count value associated with the status.
    let status: Int?

    init(status: Int?) {
        self.status = status
    }

    enum CodingKeys: String, CodingKey {
        case status
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decodeIfPresent(Int.self, forKey: .status)
    }
}
