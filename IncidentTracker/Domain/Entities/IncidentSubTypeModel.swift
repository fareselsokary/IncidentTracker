//
//  IncidentSubTypeModel.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - IncidentSubTypeModel

struct IncidentSubTypeModel: Identifiable, Titled {
    let id: Int
    let arabicName: String?
    let englishName: String?
    let categoryId: Int?

    var title: String {
        return englishName ?? arabicName ?? ""
    }

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
}
