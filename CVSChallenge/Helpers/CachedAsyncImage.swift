//
//  CachedAsyncImage.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import SwiftUI
import SwiftData

struct CachedAsyncImage<Content>: View where Content: View {
    private let url: URL
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content

    init(url: URL, scale: CGFloat = 1.0, transaction: Transaction = Transaction(), @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.url = url
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    var body: some View {
        if let cached = ImageDatabase.shared.loadImage(fromURL: url.absoluteString) {
            content(.success(cached))
        } else {
            AsyncImage (
                url: url,
                scale: scale,
                transaction: transaction
            ) { phase in
                cacheAndRender(phase: phase)
            }
        }
    }
    
    @MainActor 
    private func cacheAndRender(phase: AsyncImagePhase) -> some View {
        if case .success(let image) = phase {
            ImageDatabase.shared.save(image: image, withURL: url)
        }
        return content(phase)
    }
}

@MainActor
fileprivate class ImageDatabase {
    static var shared = ImageDatabase()
    private let container: ModelContainer?
    private let context: ModelContext?
    
    private init() {
        do {
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            self.container = try ModelContainer(for: CachedImage.self, configurations: config)
            self.context = container?.mainContext
            context?.autosaveEnabled = true
        } catch {
            container = nil
            context = nil
        }
    }
    
    func save(image: Image, withURL url: URL) {
        guard let context = context, let data = ImageRenderer(content: image).uiImage?.pngData() else {
            return
        }
        let cachedImage = CachedImage(imageURL: url.absoluteString, image: data)
        context.insert(cachedImage)
        try? context.save()
    }
    
    func loadImage(fromURL url: String) -> Image? {
        guard let context = context else {
            return nil
        }
        
        var descriptor = FetchDescriptor<CachedImage>(
            predicate: #Predicate { $0.imageURL == url }
        )
        descriptor.fetchLimit = 1
        
        do {
            let result = try context.fetch(descriptor)
            if let data = result.first?.image, let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
}
