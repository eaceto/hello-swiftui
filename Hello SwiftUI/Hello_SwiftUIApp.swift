//
//  Hello_SwiftUIApp.swift
//  Hello SwiftUI
//
//  Created by Kimi on 24/07/2021.
//

import SwiftUI

@main
struct Hello_SwiftUIApp: App {
    
    @ObservedObject private var userProfileViewModel = UserProfileViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(AppConfiguration())
                .onAppear(perform: {
                    userProfileViewModel.loadCredentials()
                })
        }
    }
}
