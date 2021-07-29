//
//  UserProfileViewModel.swift
//  Hello SwiftUI
//
//  Created by Kimi on 29/07/2021.
//

import SwiftUI
import Combine

import Auth0

class UserProfileViewModel: ObservableObject {
    
    private let credentialsManager = CredentialsManager(authentication: Auth0.authentication())
    
    private var disposables = Set<AnyCancellable>()

    @Published var userProfile: Auth0.UserInfo? = nil
    @Published var userCredentials: Auth0.Credentials? = nil {
        didSet {
            if let userCredentials = userCredentials {
                fetchUserProfile(with: userCredentials)
            } else {
                userProfile = nil
            }
        }
    }
    
    func isAuthenticated() -> Bool {
        return credentialsManager.hasValid()
    }
    
    func loadCredentials() {
        if !isAuthenticated() { return }
        
        credentialsManager.credentials { [weak self] error, credentials in
            guard error == nil, let credentials = credentials, let self = self else {
                self?.userCredentials = nil
                self?.userProfile = nil
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.userCredentials = credentials
            }
        }
    }
    
    func login() {
        Auth0
            .webAuth()
            .scope("openid profile email offline_access")
            .audience("https://eaceto.eu.auth0.com/api/v2/")
            .start { result in
                switch result {
                case .failure(let error):
                    // Handle the error
                    print("Error: \(error)")
                case .success(let credentials):
                    _ = self.credentialsManager.store(credentials: credentials)
                    DispatchQueue.main.async { [weak self] in
                        self?.userCredentials = credentials
                    }
                }
        }
    }
    
    func fetchUserProfile(with credentials: Credentials) {
        guard let accessToken = credentials.accessToken else {
            // Handle Error
            return
        }
        
        Auth0
            .authentication()
            .userInfo(withAccessToken: accessToken)
            .start { result in
                switch(result) {
                case .failure(let error):
                    print("Error: \(error)")
                case .success(let profile):
                    DispatchQueue.main.async { [weak self] in
                        self?.userProfile = profile
                    }
                }
            }
    }
    
    func logout() {
        _ = self.credentialsManager.clear()
        self.userCredentials = nil
    }
}

extension Auth0.UserInfo {
    
    //TODO Auth0.UserInfo should implement Codable. I hope to make a PR to this soon...
    func jsonEncodedProfile() -> String {
        var props = [String:Any]()
        props["sub"] = self.sub
        if let val = self.givenName { props["givenName"] = val }
        if let val = self.name { props["name"] = val }
        if let val = self.middleName { props["middleName"] = val }
        if let val = self.familyName { props["familyName"] = val }
        if let val = self.nickname { props["nickname"] = val }
        if let val = self.preferredUsername { props["preferredUsername"] = val }
        if let val = self.address { props["address"] = val }
        if let val = self.birthdate { props["birthdate"] = val }
        if let val = self.email { props["email"] = val }
        if let val = self.emailVerified { props["emailVerified"] = val }
        if let val = self.gender { props["gender"] = val }
        if let val = self.locale { props["locale"] = val.description }
        if let val = self.phoneNumber { props["phoneNumber"] = val }
        if let val = self.phoneNumberVerified { props["phoneNumberVerified"] = val }
        if let val = self.picture { props["picture"] = val.absoluteString }
        if let val = self.profile { props["profile"] = val.absoluteString }
        if let val = self.updatedAt { props["updatedAt"] = val.timeIntervalSince1970 }
        if let val = self.website { props["website"] = val.absoluteString }
        if let val = self.zoneinfo { props["website"] = val.description }
        if let val = self.customClaims, !val.isEmpty { props["customClaims"] = val }
    
        let jsonData = try! JSONSerialization.data(withJSONObject: props, options: [.prettyPrinted, .fragmentsAllowed, .sortedKeys])
        let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
        return jsonString
    }
}
