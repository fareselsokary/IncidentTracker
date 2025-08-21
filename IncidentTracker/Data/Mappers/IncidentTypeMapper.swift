//
//  IncidentTypeMapper.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - IncidentType Mapper

enum IncidentTypeMapper {
    static func map(_ response: IncidentTypeResponse) -> IncidentTypeModel {
        return IncidentTypeModel(
            id: response.id,
            arabicName: response.arabicName,
            englishName: response.englishName,
            subTypes: IncidentSubTypeMapper.map(response.subTypes)
        )
    }

    static func map(_ responses: [IncidentTypeResponse]) -> [IncidentTypeModel] {
        return responses.map { map($0) }
    }
}
