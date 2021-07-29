//
//  Cancellable+Extensions.swift
//  Hello SwiftUI
//
//  Created by Kimi on 30/07/2021.
//

import Combine

typealias DisposeBag = Set<AnyCancellable>

extension DisposeBag {
    mutating func dispose() {
        forEach { $0.cancel() }
        removeAll()
    }
}
