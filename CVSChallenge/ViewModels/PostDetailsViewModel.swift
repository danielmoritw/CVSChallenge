//
//  PostDetailsViewModel.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation
import SwiftUI

@Observable class PostDetailsViewModel {
    private(set) var loadedImage: Image?
    
    func imageLoaded(image: Image) {
        self.loadedImage = image
    }
}
