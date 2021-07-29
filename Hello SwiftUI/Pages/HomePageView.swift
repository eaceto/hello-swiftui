//
//  HomePageView.swift
//  Hello SwiftUI
//
//  Created by Kimi on 25/07/2021.
//

import SwiftUI
#if os(iOS)
import BetterSafariView
#endif

struct HomePageView: View {
    
    @EnvironmentObject var appConfiguration: AppConfiguration
    
    @State private var presentingSafariView = false
    @State private var presentingURL: URL? = nil

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                VStack {
                    
                    #if targetEnvironment(macCatalyst)
                    HStack {
                        
                    }
                    #endif
                    
                    Button(action: {
                        openSwiftQuickStart()
                    })
                    {
                        FeaturedBanner(
                            image: Image("SwiftUILogo"),
                            title: "Hello, SwiftUI!",
                            briefDescription: "This is a sample application that demonstrates the authentication flow for a SwiftUI app using Auth0.",
                            actionLabel: "Check out the SwiftUI QuickStart →",
                            gradientStartColor: Color("BannerGradientStartColor"),
                            gradientEndColor: Color("BannerGradientEndColor")
                        )
                    }
                    
                    Spacer()
                        .frame(height: 48)
                    
                    Text("Explore Auth0 Features")
                        .font(.title)
                    
                    ForEach(appConfiguration.features) { feature in
                        Button(action: {
                            openFeatureDetails(feature)
                        })
                        {
                            FeatureBanner(feature: feature)
                        }
                        .padding(8)
                        
                    }
                }
                .padding()
                .navigationBarItems(leading:
                                        Button(action: {
                                            openHomePage()
                                        }
                                        ) {
                                            Image("Auth0Logo")
                                                .renderingMode(.template)
                                        },
                                    trailing:
                                        NavigationLink(
                                            destination: AboutPageView()    ,
                                            label: {
                                                Image(systemName: "info.circle.fill")
                                            }
                                        )
                                    
                )
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.large)
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGroupedBackground))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .safariView(isPresented: $presentingSafariView, onDismiss: {
            self.presentingURL = nil
        }) {
            SafariView(
                url: self.presentingURL!,
                configuration: SafariView.Configuration(
                    entersReaderIfAvailable: false,
                    barCollapsingEnabled: true
                )
            )
            .dismissButtonStyle(.done)
        }
        .onChange(of: presentingURL, perform: { value in
            self.presentingSafariView = value != nil
        })
    }
    
    func openHomePage() {
        self.presentingURL = appConfiguration.examplePageURL
    }
    
    func openSwiftQuickStart() {
        self.presentingURL = appConfiguration.languageTutorialURL
    }
    
    func openFeatureDetails(_ feature: Feature) {
        if let url = URL(string: feature.linkURL) {
            self.presentingURL = url
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
