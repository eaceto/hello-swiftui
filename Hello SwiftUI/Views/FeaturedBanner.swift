//
//  FeaturedBanner.swift
//  Hello SwiftUI
//
//  Created by Kimi on 27/07/2021.
//

import SwiftUI

struct FeaturedBanner: View {
    
    var image: Image
    var title: String
    var briefDescription: String
    var actionLabel: String
    var gradientStartColor: Color
    var gradientEndColor: Color
    
    var body: some View {
        VStack {
            image
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            VStack {
                Text(briefDescription)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .frame(maxHeight: .infinity)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
            
                VStack{
                    Text(actionLabel)
                        .foregroundColor(Color.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .frame(maxHeight: .infinity)
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [gradientStartColor, gradientEndColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(16)
    }
}

struct FeaturedBanner_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedBanner(
            image: Image("SwiftUILogo"),
            title: "Hello, SwiftUI!",
            briefDescription: "This is a sample application that demonstrates the authentication flow for a SwiftUI app using Auth0.",
            actionLabel: "Check out the SwiftUI QuickStart →",
            gradientStartColor: Color("BannerGradientStartColor"),
            gradientEndColor: Color("BannerGradientEndColor")
        )
    }
}
