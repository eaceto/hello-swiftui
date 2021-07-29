//
//  ImageLoader.swift
//  Hello SwiftUI
//
//  Created by Kimi on 31/07/2021.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
        
    private let url: URL

    private var cancellable: AnyCancellable?
    
    @Published var image: UIImage?

    
    init(url: URL) {
        self.url = url
    }

    deinit {
        cancel()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { UIImage(data: $0.data) }
                    .replaceError(with: nil)
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] in self?.image = $0 }
    }

    func cancel() {
        cancellable?.cancel()
    }
}
