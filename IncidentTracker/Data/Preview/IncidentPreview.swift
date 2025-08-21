//
//  IncidentModel.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - Incident Mock Extension

extension Incident {
    /// Single mock incident
    static let mock = Incident(
        id: "69030db3-ee9f-433f-8573-ebb2bc7bc4ee",
        description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
        latitude: 0,
        longitude: 0,
        status: .completed,
        priority: 4,
        typeId: 24,
        issuerId: "af698686-7470-499b-a745-765e89b3c4b4",
        assigneeId: "8afc5220-f8fc-11eb-9a03-0242ac130003",
        createdAt: .now,
        updatedAt: .now,
        media: [IncidentMediaModel.mock]
    )

    /// List of mock incidents
    static let mocks: [Incident] = [
        Incident(
            id: "69030db3-ee9f-433f-8573-ebb2bc7bc4ee",
            description: "korsi",
            latitude: 0,
            longitude: 0,
            status: .completed,
            priority: 4,
            typeId: 24,
            issuerId: "af698686-7470-499b-a745-765e89b3c4b4",
            assigneeId: "8afc5220-f8fc-11eb-9a03-0242ac130003",
            createdAt: .now,
            updatedAt: .now,
            media: [IncidentMediaModel.mock]
        ),
        Incident(
            id: "0fe3d00f-5e75-438d-ac77-449fbb366d31",
            description: "تيست\n ************************************* \n 2021-12-28 22:31:19.904105 \nتيست سلل",
            latitude: 0,
            longitude: 0,
            status: .rejected,
            priority: 3,
            typeId: 25,
            issuerId: "af698686-7470-499b-a745-765e89b3c4b4",
            assigneeId: nil,
            createdAt: .now,
            updatedAt: .now,
            media: [IncidentMediaModel.mocks[1]]
        )
    ]
}
