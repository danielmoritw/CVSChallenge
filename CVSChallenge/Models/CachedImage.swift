//
//  CachedImage.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation
import SwiftData

@Model
class CachedImage {
    @Attribute(.unique) var id: UUID = UUID()
    var imageURL: String
    @Attribute(.externalStorage) var image: Data?
    
    init(imageURL: String, image: Data? = nil) {
        self.imageURL = imageURL
        self.image = image
    }
}
