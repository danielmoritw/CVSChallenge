//
//  SearchableGridView.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import SwiftUI

struct SearchableGridView: View {
    @State private var networkMonitor = NetworkMonitorService()
    @State private var viewModel: SearchableGridViewModel
    
    init(viewModel: SearchableGridViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            TextField("Search for image...", text: $viewModel.searchTerm)
                .textFieldStyle(.roundedBorder)
                .padding()
                .accessibilityAddTraits(.isSearchField)
                .accessibilityLabel("Text field for searching new images.")
                .onChange(of: viewModel.searchTerm) {
                    Task {
                        await viewModel.loadPosts()
                    }
                }
            if !networkMonitor.isConnected {
                Label("No internet connection", systemImage: "wifi.slash")
                    .symbolEffect(.pulse)
                    .accessibilityAddTraits(.isStaticText)
            }
            
            if viewModel.posts.count > 0 {
                ScrollablePostGridView(numberOfColumns: viewModel.gridWithMultipleLines ? 3 : 1, posts: viewModel.posts) { post in
                    viewModel.selectedPost(post: post)
                }
                .padding()
                .refreshable {
                    await viewModel.loadPosts()
                }
            } else {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                GridToggleButton(gridWithMultipleLines: $viewModel.gridWithMultipleLines)
            }
        }
        .sheet(item: $viewModel.selectedPost, content: { post in
            PostDetailsView(post: post, viewModel: PostDetailsViewModel())
        })
        .alert(isPresented: $viewModel.hasFailedLoadingPosts, content: {
            Alert(
                title: Text("Something went wrong"),
                dismissButton:
                        .cancel(Text("Try again."),
                                action: {
                                    Task {
                                        await viewModel.loadPosts()
                                    }
                                }))
        })
        .onAppear {
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        .task {
            await viewModel.loadPosts()
        }
        .navigationTitle("Flickr")
        .navigationBarTitleDisplayMode(.automatic)
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview("Success State") {
    NavigationStack {
        SearchableGridView(viewModel: SearchableGridViewModel(service: FlickrService()))
    }
}

#Preview("Error State") {
    NavigationStack {
        SearchableGridView(viewModel: SearchableGridViewModel(service: ErrorService()))
    }
}

fileprivate struct ErrorService: FlickrServiceProtocol {
    func getImages(searchTerm: String) async throws -> [Post] {
        throw HTTPError.invalidURL
    }
    
    
}
