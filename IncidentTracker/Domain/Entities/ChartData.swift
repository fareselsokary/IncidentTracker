//
//  ChartData.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Foundation

// MARK: - ChartDataPoint

struct ChartDataPoint: Identifiable {
    let id: UUID
    let label: String
    let value: Double

    init(
        id: UUID = UUID(),
        label: String,
        value: Double
    ) {
        self.id = id
        self.label = label
        self.value = value
    }
}

// MARK: - ChartData

struct ChartData {
    let xAxisTitle: String?
    let yAxisTitle: String?
    let dataPoints: [ChartDataPoint]

    init(
        xAxisTitle: String? = nil,
        yAxisTitle: String? = nil,
        dataPoints: [ChartDataPoint]
    ) {
        self.xAxisTitle = xAxisTitle
        self.yAxisTitle = yAxisTitle
        self.dataPoints = dataPoints
    }
}
