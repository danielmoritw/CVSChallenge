//
//  SearchableGridViewModelTests.swift
//  CVSChallengeTests
//
//  Created by Daniel Mori on 02/09/24.
//

import XCTest
@testable import CVSChallenge

final class SearchableGridViewModelTests: XCTestCase {
    
    func testLoadPosts() async throws {
        let sut = SearchableGridViewModel(service: MockService())
        await sut.loadPosts(withDebounce: 0.0)
        let expectation = expectation(description: "Load posts")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertTrue(sut.posts.count == 5, "Error: posts count is \(sut.posts.count)")
    }
}

fileprivate struct MockService: FlickrServiceProtocol {
    func getImages(searchTerm: String) async throws -> [Post] {
        Array(repeating: Post(title: "Post", link: "https://cvs.com", media: Media(image: "https://cvs.com"), published: "", author: "Daniel", tags: "tag 1, tag 2, tag 3", description: "desc"), count: 5)
    }
}
