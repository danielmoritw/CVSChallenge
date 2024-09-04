//
//  Item.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
