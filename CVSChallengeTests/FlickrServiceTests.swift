//
//  FlickrServiceTests.swift
//  CVSChallengeTests
//
//  Created by Daniel Mori on 02/09/24.
//

import XCTest
@testable import CVSChallenge

final class FlickrServiceTests: XCTestCase {
    func testSuccessfulAPICall() async throws {
        let sut = FlickrService(httpClient: MockHTTPClient())
        let response = try await sut.getImages(searchTerm: "")
        XCTAssertNotNil(response)
    }
    
    func testNotFailingAPICall() async throws {
        let sut = FlickrService(httpClient: MockHTTPClient())
        var failingError: Error? = nil
        do {
            let _ = try await sut.getImages(searchTerm: "")
        } catch {
            failingError = error
        }
        XCTAssertNil(failingError)
    }
    
    func testFailingAPICall() async throws {
        let sut = FlickrService(httpClient: ThrowableMockHTTPClient())
        var failingError: Error? = nil
        do {
            let _ = try await sut.getImages(searchTerm: "")
        } catch {
            failingError = error
        }
        XCTAssertNotNil(failingError)
    }
}

fileprivate struct MockHTTPClient: HTTPClientProtocol {
    func load<T>(url: String) async throws -> T where T : Decodable {
        let response = try JSONDecoder().decode(T.self, from: getData(name: "FlickrResponseMock") ?? Data())
        return response
    }
    
    func getData(name: String, withExtension ext: String = "json") -> Data? {
        if let url = Bundle(for: FlickrServiceTests.self).url(forResource: "FlickrResponseMock", withExtension: ext) {
            do {
                let data = try Data(contentsOf: url)
                return data
            } catch {
                print("error:\(error)")
            }
        }
        return nil
        
    }
}

fileprivate struct ThrowableMockHTTPClient: HTTPClientProtocol {
    func load<T>(url: String) async throws -> T where T : Decodable {
        throw HTTPError.invalidURL
    }
}
