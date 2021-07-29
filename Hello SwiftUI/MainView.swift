//
//  MainView.swift
//  Hello SwiftUI
//
//  Created by Kimi on 24/07/2021.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            HomePageView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            UserProfilePageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("My profile")
                }
            APITestPageView()
                .tabItem {
                    Image(systemName: "network")
                    Text("External API")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
