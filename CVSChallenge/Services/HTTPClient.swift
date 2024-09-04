//
//  HTTPClient.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
}

protocol HTTPClientProtocol {
    func load<T: Decodable>(url: String) async throws -> T
}

struct HTTPClient: HTTPClientProtocol {
    func load<T: Decodable>(url: String) async throws -> T {
        guard let url = URL(string: url)
        else {
            throw HTTPError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(T.self, from: data)
        return response
    }
}
