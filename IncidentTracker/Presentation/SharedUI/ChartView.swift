//
//  ChartView.swift
//  IncidentTracker
//
//  Created by fares on 22/08/2025.
//

import Charts
import SwiftUI

// MARK: - ChartView

/// A reusable chart view that renders a line chart with data points.
///
/// It uses Swift Charts to plot values from `ChartData` and allows
/// optional axis titles.
///
/// Example:
/// ```swift
/// let chartData = ChartData(
///     xAxisTitle: "Status",
///     yAxisTitle: "Number of Incidents",
///     dataPoints: [
///         ChartDataPoint(label: "Open", value: 10),
///         ChartDataPoint(label: "In Progress", value: 5),
///         ChartDataPoint(label: "Closed", value: 8)
///     ]
/// )
///
/// ChartView(chartData: chartData)
///     .frame(height: 200)
/// ```
struct ChartView: View {
    let chartData: ChartData

    var body: some View {
        Chart {
            ForEach(chartData.dataPoints) { point in
                LineMark(
                    x: .value("Label", point.label),
                    y: .value("Value", point.value)
                )
                .interpolationMethod(.catmullRom) // smoother curve

                PointMark(
                    x: .value("Label", point.label),
                    y: .value("Value", point.value)
                )
            }
        }
        .foregroundStyle(.orange)
        .chartLegend(.hidden)
        .if(chartData.xAxisTitle != nil) { view in
            view.chartXAxisLabel(
                chartData.xAxisTitle ?? "",
                position: .bottom,
                alignment: .center
            )
        }
        .if(chartData.yAxisTitle != nil) { view in
            view.chartYAxisLabel(chartData.yAxisTitle ?? "")
        }
    }
}

// MARK: - ChartDataPoint

/// Represents a single data point in the chart.
struct ChartDataPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}

// MARK: - ChartData

/// Container for chart configuration and data.
struct ChartData {
    let xAxisTitle: String?
    let yAxisTitle: String?
    let dataPoints: [ChartDataPoint]
}

// MARK: - Preview

#Preview {
    let sampleDataPoints = [
        ChartDataPoint(label: "Open", value: 10),
        ChartDataPoint(label: "In Progress", value: 5),
        ChartDataPoint(label: "Closed", value: 8)
    ]

    let sampleChartData = ChartData(
        xAxisTitle: "Status",
        yAxisTitle: "Number of Incidents",
        dataPoints: sampleDataPoints
    )

    ChartView(chartData: sampleChartData)
        .frame(height: 200)
        .padding()
        .background(.black.opacity(0.1))
}
