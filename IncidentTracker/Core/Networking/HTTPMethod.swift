//
//  HTTPMethod.swift
//  IncidentTracker
//
//  Created by fares on 21/08/2025.
//


/// Represents the HTTP methods supported by the networking layer.
///
/// Each case corresponds to a standard HTTP request method,
/// and its raw value is the exact string used in HTTP headers.
enum HTTPMethod: String {
    /// The `GET` method requests a representation of the resource.
    /// Requests using `GET` should not have a request body.
    case get = "GET"

    /// The `POST` method submits data to the server,
    /// often causing a new resource to be created.
    case post = "POST"

    /// The `PUT` method replaces the resource at the given URI
    /// with the payload provided in the request body.
    case put = "PUT"

    /// The `DELETE` method deletes the specified resource.
    case delete = "DELETE"
}
