//
//  AppFeatureDescription.swift
//  Hello SwiftUI
//
//  Created by Kimi on 01/08/2021.
//

import SwiftUI

struct AppFeatureDescription: View {
    
    private(set) var title: String
    private(set) var description: String
    
    var body: some View {
        appFeatureDescription(title: title, description: description)
    }
    
    fileprivate func appFeatureDescription(title: String, description: String) -> some View {
        return HStack {
            
            VStack {
                Text(title)
                    .font(.title)
                
                Spacer()
                    .frame(height: 8)
                
                Text(description)
                    .font(.subheadline)
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity)
            .padding(16)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            .cornerRadius(16)
        }
    }
}

struct AppFeatureDescription_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AppFeatureDescription(title: "Title", description: "You can use an ID Token to get the profile information of a logged-in user.")
                .padding()
            
            Spacer()
        }
        .background(Color.black)
            
    }
}
