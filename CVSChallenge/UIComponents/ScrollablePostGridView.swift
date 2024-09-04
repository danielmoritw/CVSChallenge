//
//  ScrollablePostGridView.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import SwiftUI

struct ScrollablePostGridView: View {
    let numberOfColumns: Int
    let posts: [Post]
    let onTap: (Post) -> Void
    
    var body: some View {
        let columnConfiguration = Array(repeating: GridItem(.flexible(minimum: 40)), count: numberOfColumns)
        ScrollView {
            LazyVGrid(columns: columnConfiguration) {
                ForEach(posts, id: \.media.image) { post in
                    PostGridItemView(url: post.url)
                        .onTapGesture {
                            onTap(post)
                        }
                }
            }
        }
        .animation(.bouncy, value: numberOfColumns)
        .scrollDismissesKeyboard(.immediately)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    ScrollablePostGridView(numberOfColumns: 3, posts: FlickrResponse.mock, onTap: { _ in })
}
