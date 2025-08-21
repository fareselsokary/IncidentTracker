//
//  IncidentSubTypeMapper.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - IncidentSubType Mapper

enum IncidentSubTypeMapper {
    static func map(_ response: IncidentSubTypeResponse) -> IncidentSubTypeModel {
        return IncidentSubTypeModel(
            id: response.id,
            arabicName: response.arabicName,
            englishName: response.englishName,
            categoryId: response.categoryId
        )
    }

    static func map(_ responses: [IncidentSubTypeResponse]?) -> [IncidentSubTypeModel] {
        guard let responses = responses else { return [] }
        return responses.map { map($0) }
    }
}
