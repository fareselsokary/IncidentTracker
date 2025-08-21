//
//  IncidentTypeResponse.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - IncidentType

struct IncidentTypeResponse: Decodable {
    let id: Int
    let arabicName: String?
    let englishName: String?
    let subTypes: [IncidentSubTypeResponse]?

    init(
        id: Int,
        arabicName: String?,
        englishName: String?,
        subTypes: [IncidentSubTypeResponse]?
    ) {
        self.id = id
        self.arabicName = arabicName
        self.englishName = englishName
        self.subTypes = subTypes
    }

    enum CodingKeys: String, CodingKey {
        case id
        case arabicName
        case englishName
        case subTypes
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        arabicName = try container.decodeIfPresent(String.self, forKey: .arabicName)
        englishName = try container.decodeIfPresent(String.self, forKey: .englishName)
        subTypes = try container.decodeIfPresent([IncidentSubTypeResponse].self, forKey: .subTypes)
    }
}

// MARK: - IncidentSubType

struct IncidentSubTypeResponse: Decodable {
    let id: Int
    let arabicName: String?
    let englishName: String?
    let categoryId: Int?

    init(
        id: Int,
        arabicName: String?,
        englishName: String?,
        categoryId: Int?
    ) {
        self.id = id
        self.arabicName = arabicName
        self.englishName = englishName
        self.categoryId = categoryId
    }

    enum CodingKeys: String, CodingKey {
        case id
        case arabicName
        case englishName
        case categoryId
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        arabicName = try container.decodeIfPresent(String.self, forKey: .arabicName)
        englishName = try container.decodeIfPresent(String.self, forKey: .englishName)
        categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
    }
}
