//
//  PostModelTests.swift
//  CVSChallengeTests
//
//  Created by Daniel Mori on 02/09/24.
//

import XCTest
@testable import CVSChallenge

final class PostModelTests: XCTestCase {

    func testInitialization() throws {
        let sut = Post(title: "", link: "", media: Media(image: ""), published: "", author: "", tags: "", description: "")
        XCTAssertNotNil(sut)
    }
    
    func testPostURL() throws {
        let sut = Post(title: "", link: "", media: Media(image: "https://www.cvs.com/"), published: "", author: "", tags: "", description: "")
        XCTAssertNotNil(sut.url)
    }

}
