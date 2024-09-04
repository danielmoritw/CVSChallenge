//
//  FlickrService.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation

protocol FlickrServiceProtocol {
    func getImages(searchTerm: String) async throws -> [Post]
}

struct FlickrService: FlickrServiceProtocol {
    let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func getImages(searchTerm: String) async throws -> [Post] {
        let term = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? searchTerm
        let response: FlickrResponse = try await httpClient.load(url: "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=\(term)")
            
        return response.posts
    }
}

fileprivate struct JSONResponse {
    static var response: String = "{}"
}

