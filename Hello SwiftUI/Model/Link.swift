//
//  Link.swift
//  Hello SwiftUI
//
//  Created by Kimi on 27/07/2021.
//

import Foundation

struct Link: Codable {

    let title: String
    let url: String
    
}

extension Link: Identifiable {
    var id: String { return url }
}

typealias Links = [Link]
