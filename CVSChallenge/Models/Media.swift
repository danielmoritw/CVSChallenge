//
//  Media.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation

struct Media: Decodable {
    let image: String
    private enum CodingKeys: String, CodingKey {
        case image = "m"
    }
}
