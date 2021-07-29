//
//  Feature.swift
//  Hello SwiftUI
//
//  Created by Kimi on 27/07/2021.
//

import Foundation
import SwiftUI

struct Feature: Codable {
    
    let iconName: String
    let title: String
    let briefDescription: String
    let linkURL: String
    
}

extension Feature: Identifiable {
    var id: String { return linkURL }
}

typealias Features = [Feature]
