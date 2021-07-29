//
//  UserProfileView.swift
//  Hello SwiftUI
//
//  Created by Kimi on 25/07/2021.
//

import SwiftUI

struct UserProfilePageView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    
                }
                .padding()
                .navigationTitle("User Profile")
                .navigationBarTitleDisplayMode(.large)
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGroupedBackground))
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfilePageView()
    }
}
