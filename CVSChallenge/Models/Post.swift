//
//  Post.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation

struct Post: Decodable {
    let title: String
    let link: String
    let media: Media
    let published: String
    let author: String
    let tags: String
    let description: String
}

extension Post: Identifiable, Equatable {
    var id: UUID {
        UUID()
    }
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
}

extension Post {
    var url: URL? {
        URL(string: self.media.image)
    }

    var tagsArray: [String] {
        tags.components(separatedBy: " ")
    }

    var authorName: String {
        author.components(separatedBy: " ").last?.alphanumerical ?? author
    }

    var width: String {
        description.components(separatedBy: " ").filter { $0.contains("width") }.first?.numericValue ?? ""
    }

    var height: String {
        description.components(separatedBy: " ").filter { $0.contains("height") }.first?.numericValue ?? ""
    }
}
