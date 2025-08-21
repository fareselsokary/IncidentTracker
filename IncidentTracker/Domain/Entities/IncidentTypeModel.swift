//
//  IncidentTypeModel.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - IncidentType

struct IncidentTypeModel: Identifiable, Titled {
    let id: Int
    let arabicName: String?
    let englishName: String?
    let subTypes: [IncidentSubTypeModel]?

    var title: String {
        return englishName ?? arabicName ?? ""
    }

    init(
        id: Int,
        arabicName: String?,
        englishName: String?,
        subTypes: [IncidentSubTypeModel]?
    ) {
        self.id = id
        self.arabicName = arabicName
        self.englishName = englishName
        self.subTypes = subTypes
    }
}
