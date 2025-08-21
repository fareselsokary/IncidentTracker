//
//  MultipartFile.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//

import Foundation

// MARK: - MultipartFile

/// Represents a single file to be uploaded as part of
/// a multipart/form-data request.
///
/// Each file requires:
/// - `name`: The form field name (e.g. `"file"`)
/// - `filename`: The name to send to the server (e.g. `"image.jpg"`)
/// - `mimeType`: The MIME type of the file (e.g. `"image/jpeg"`)
/// - `data`: The raw binary data of the file
struct MultipartFile: MultipartFileProtocol {
    let name: String
    let filename: String
    let mimeType: String
    let data: Data
}
