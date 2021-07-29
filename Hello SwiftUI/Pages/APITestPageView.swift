//
//  APITestPageView.swift
//  Hello SwiftUI
//
//  Created by Kimi on 25/07/2021.
//

import SwiftUI

struct APITestPageView: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    
                }
                .padding()
                .navigationTitle("External API")
                .navigationBarTitleDisplayMode(.large)
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGroupedBackground))
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct APITestPageView_Previews: PreviewProvider {
    static var previews: some View {
        APITestPageView()
    }
}
