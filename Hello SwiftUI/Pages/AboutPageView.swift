//
//  AboutPageView.swift
//  Hello SwiftUI
//
//  Created by Kimi on 27/07/2021.
//

import SwiftUI
#if os(iOS)
import BetterSafariView
#endif

struct AboutPageView: View {
    
    @EnvironmentObject var appConfiguration: AppConfiguration
    
    @State private var presentingSafariView = false
    @State private var presentingURL: URL? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                Button(action: {
                    self.presentingURL = appConfiguration.homePageURL
                })
                {
                    HStack {
                        Image("Auth0Logo")
                        Text("Auth0 Inc.")
                            .bold()
                            .font(.title2)
                    }
                    .padding()
                }
                
                Text("This sample application is brought to you by Auth0.")
                    .font(.title3)
                
                
                Text("Securely implement authentication using Auth0 on any stack and any device ") + Text("in less than 10 minutes.").underline()
                
                Spacer()
                    .frame(height: 48)
                
                VStack {
                    Button("Create Auth0 Free Account") {
                        self.presentingURL = appConfiguration.createAccountURL
                    }
                    .font(.title3.bold())
                }
                .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity)
                .padding()
                .background(Color(UIColor.secondarySystemGroupedBackground))
                .cornerRadius(16)
                
                Spacer()
                    .frame(height: 48)
                
                ForEach(appConfiguration.aboutLinks) { link in
                    VStack {
                        Button(link.title) {
                            self.presentingURL = URL(string: link.url)!
                        }
                    }
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                }
                
                Spacer()
                    .frame(height: 16)
                
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationBarTitle("About", displayMode: .inline)
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
}

struct AboutPageView_Previews: PreviewProvider {
    static var previews: some View {
        AboutPageView()
    }
}
