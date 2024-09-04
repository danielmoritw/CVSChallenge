//
//  SearchableGridViewModel.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation

@Observable class SearchableGridViewModel {
    private(set) var posts: [Post] = []
    private let service: FlickrServiceProtocol
    var searchTerm: String = ""
    var selectedPost: Post?
    var gridWithMultipleLines = true
    var hasFailedLoadingPosts: Bool = false
    private var loadTask: DispatchWorkItem?
    
    init(service: FlickrServiceProtocol) {
        self.service = service
    }
    
    func loadPosts(withDebounce debounce: Double = 0.5) async {
        self.loadTask?.cancel()
        let task = DispatchWorkItem { [unowned self] in
            DispatchQueue.global(qos: .userInteractive).async { [unowned self] in
                Task {
                    do {
                        // isEmpty validation just to keep it safe for work, as inappropriate results might appear
                        self.posts = try await self.service.getImages(searchTerm: self.searchTerm.isEmpty ? "Birds" : self.searchTerm)
                    } catch {
                        self.hasFailedLoadingPosts = true
                        posts = []
                    }
                }
            }
        }
        self.loadTask = task
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + debounce, execute: task)
    }
    
    /// Sets the selected Post in the ViewModel
    /// - Parameter post: Post selected by the user
    func selectedPost(post: Post) {
        self.selectedPost = post
    }
}
