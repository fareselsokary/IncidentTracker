//
//  MultipartFileProtocol.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

/// A protocol representing a file to be uploaded in a
/// multipart/form-data request.
///
/// Conforming types must provide:
/// - `name`: The form field name
/// - `filename`: The name to send to the server
/// - `mimeType`: The file’s MIME type (e.g., `"image/jpeg"`)
/// - `data`: The raw binary data of the file
protocol MultipartFileProtocol {
    var name: String { get }
    var filename: String { get }
    var mimeType: String { get }
    var data: Data { get }
}
