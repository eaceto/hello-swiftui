//
//  APITestPageView.swift
//  Hello SwiftUI
//
//  Created by Kimi on 25/07/2021.
//

import SwiftUI
import Auth0

struct APITestPageView: View {
    
    @State private var authenticationStep: AuthenticationStep?
    @ObservedObject private var userProfileViewModel = UserProfileViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                AppFeatureDescription(title: "External API",
                                          description: "You can use the buttons below make calls to an external API.\nOnly logged-in users can access use this page.")
                    .padding()
                    
                VStack {
                    if let authenticationStep = authenticationStep {
                        switch authenticationStep {
                        case .nonAuthenticated:
                            userNonAuthenticatedView
                        case .hasUserProfile:
                            Spacer()
                        default:
                            Spacer()
                        }
                    }
                }
                .padding()
                .navigationTitle("External API")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarItems(trailing: loginButton)
            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor.systemGroupedBackground))
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            if !userProfileViewModel.isAuthenticated() {
                authenticationStep = .nonAuthenticated
            }
            
            userProfileViewModel.loadCredentials()
            
            _ = userProfileViewModel.$userCredentials.subscribe(on: RunLoop.main).sink(receiveValue: { userCredential in
                updateViewState(with: userCredential)
            })
            
            _ =  userProfileViewModel.$userProfile.subscribe(on: RunLoop.main).sink(receiveValue: { userProfile in
                updateViewState(with: userProfile)
            })
        })
    }
    
    var loginButton: some View {
        if userProfileViewModel.isAuthenticated() {
            return Button("Log out") {
                userProfileViewModel.logout()
            }
        }
        return Button("Log in") {
            userProfileViewModel.login()
        }
    }
    
    var userNonAuthenticatedView: some View {
        VStack {
            Text("Opsss... you are not authenticated. Log in!")
                .font(.footnote)
            
            Spacer()
            
            VStack {
                Button("Log in") {
                    authenticationStep = .authenticating
                    userProfileViewModel.login()
                }
                .font(.title3.bold())
                .foregroundColor(.white)
            }
            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity)
            .padding()
            .background(Color.purple)
            .cornerRadius(16)
        }
    }
}

extension APITestPageView {
    
    private func updateViewState(with credentials: Auth0.Credentials?) {
        let profile = userProfileViewModel.userProfile
        
        if credentials != nil {
            authenticationStep = .authenticated
            if profile != nil {
                authenticationStep = .hasUserProfile
            }
            return
        }
        
        if authenticationStep != .authenticating {
            authenticationStep = .nonAuthenticated
        }
    }
    
    private func updateViewState(with userProfile: Auth0.UserInfo?) {
        let credentials = userProfileViewModel.userCredentials
        
        if credentials != nil && userProfile != nil {
            authenticationStep = .hasUserProfile
            return
        }
        
        if authenticationStep != .authenticating {
            authenticationStep = .nonAuthenticated
        }
    }
}


struct APITestPageView_Previews: PreviewProvider {
    static var previews: some View {
        APITestPageView()
    }
}
