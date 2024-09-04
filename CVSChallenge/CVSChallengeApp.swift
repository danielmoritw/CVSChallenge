//
//  CVSChallengeApp.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import SwiftUI
import SwiftData

@main
struct CVSChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            let service = FlickrService()
            let viewModel = SearchableGridViewModel(service: service)
            NavigationStack {
                SearchableGridView(viewModel: viewModel)
            }
        }
    }
}
