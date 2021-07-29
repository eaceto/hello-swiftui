//
//  FeatureBanner.swift
//  Hello SwiftUI
//
//  Created by Kimi on 27/07/2021.
//

import SwiftUI

struct FeatureBanner: View {
    
    var feature: Feature
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                HStack(alignment: .center) {
                    Image(feature.iconName)
                        .resizable()
                        .frame(width: 52, height: 52, alignment: .leading)
                    
                    Text(feature.title)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                
                Text(feature.briefDescription)
                    .font(.subheadline)
            }
        }
        .frame(minWidth: 0,
               idealWidth: .infinity,
               maxWidth: .infinity,
               alignment: .top)
        .padding(24)
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
}

struct FeatureBanner_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FeatureBanner(
                feature:
                    Feature(
                        iconName: "EnterpriseMFAIcon",
                        title: "Multi-Factor Authentication",
                        briefDescription: "You can require your users to provide more than one piece of identifying information when logging in. MFA delivers one-time codes to your users via SMS, voice, email, WebAuthn, and push notifications.\n",
                        linkURL: "https://eaceto.dev"
                    )
            )
        }.background(Color.blue)
    }
}
