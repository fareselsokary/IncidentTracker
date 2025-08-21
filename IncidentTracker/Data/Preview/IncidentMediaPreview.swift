//
//  IncidentMediaPreview.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - IncidentMediaModel Mock Extension

extension IncidentMediaModel {
    /// Single mock media
    static let mock = IncidentMediaModel(
        id: "662c1343-ecb7-4d1c-a368-92a32d210599",
        mimeType: "image/jpg",
        url: "https://picsum.photos/200/300",
        type: 0,
        incidentId: "69030db3-ee9f-433f-8573-ebb2bc7bc4ee"
    )

    /// List of mock media
    static let mocks: [IncidentMediaModel] = [
        IncidentMediaModel(
            id: "662c1343-ecb7-4d1c-a368-92a32d210599",
            mimeType: "image/jpg",
            url: "https://picsum.photos/200/300",
            type: 0,
            incidentId: "69030db3-ee9f-433f-8573-ebb2bc7bc4ee"
        ),
        IncidentMediaModel(
            id: "c9940c8b-8b97-4419-8d09-7352b15eb02a",
            mimeType: "image/jpg",
            url: "https://picsum.photos/200/300",
            type: 0,
            incidentId: "0fe3d00f-5e75-438d-ac77-449fbb366d31"
        )
    ]
}
