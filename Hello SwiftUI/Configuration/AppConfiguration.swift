//
//  AppConfiguration.swift
//  Hello SwiftUI
//
//  Created by Kimi on 26/07/2021.
//

import SwiftUI
import Combine

class AppConfiguration: ObservableObject {
    
    @Published var homePageURL = URL(string: "https://auth0.com")!
    @Published var examplePageURL = URL(string: "https://hello-angular.auth0.works")!
    @Published var languageTutorialURL = URL(string: "https://auth0.com/docs/quickstart/native/ios-swift")!
    @Published var createAccountURL = URL(string: "https://auth0.com/signup")!
    @Published var features = AppConfiguration.loadFeaturesFromFile()
    @Published var aboutLinks = AppConfiguration.loadAboutLinksFromFile()
    
    fileprivate static func loadFeaturesFromFile() -> Features {
        guard let jsonData = loadJSONFromFile(named: "features"),
              let features = try? JSONDecoder().decode(Features.self, from: jsonData) else {
            fatalError("Could not load features.json")
        }
        return features
    }
    
    fileprivate static func loadAboutLinksFromFile() -> Links {
        guard let jsonData = loadJSONFromFile(named: "about_links"),
              let links = try? JSONDecoder().decode(Links.self, from: jsonData) else {
            fatalError("Could not load about_links.json")
        }
        return links
    }
    
    fileprivate static func loadJSONFromFile(named: String) -> Data? {
        guard let fileURL = Bundle.main.url(forResource: named, withExtension: "json"),
              let jsonData = try? Data(contentsOf: fileURL) else { return nil }
        return jsonData
    }
}
