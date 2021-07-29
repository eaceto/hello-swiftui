//
//  Hello_SwiftUIApp.swift
//  Hello SwiftUI
//
//  Created by Kimi on 24/07/2021.
//

import SwiftUI

@main
struct Hello_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(AppConfiguration())
        }
    }
}
