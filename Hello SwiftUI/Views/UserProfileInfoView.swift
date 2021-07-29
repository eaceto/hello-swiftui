//
//  UserProfileInfoView.swift
//  Hello SwiftUI
//
//  Created by Kimi on 31/07/2021.
//

import SwiftUI
import Auth0

struct UserProfileInfoView: View {

    private(set) var userProfile: Auth0.UserInfo
    
    var body: some View {
        
        let name = (userProfile.name ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        let profileImageURL = userProfile.picture
        
        let profileImagePlaceholder = Image("Auth0Logo")
            .resizable()
            .frame(width: 128, height: 128)
            .padding()
            .background(Color.white)
        
        return VStack(alignment: .leading) {
            HStack(alignment: .center) {
                VStack {
                    Group {
                        if let profileImageURL = profileImageURL {
                            NetworkImage(url: profileImageURL) {
                                profileImagePlaceholder
                            }
                        } else {
                            profileImagePlaceholder
                        }
                    }
                }
                .background(Color.black)
                .frame(width: 128, height: 128)
                .cornerRadius(64)
                
                Group {
                    if !name.isEmpty {
                        Text(name)
                            .font(.largeTitle)
                    }
                }
                .padding(.leading, 10)
                
                Spacer()
            }
            .frame(minWidth: 0,
                   idealWidth: .infinity,
                   maxWidth: .infinity,
                   alignment: .top)
            
            VStack {
                Text(userProfile.jsonEncodedProfile())
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground))
            .frame(minWidth: 0,
                   idealWidth: .infinity,
                   maxWidth: .infinity,
                   alignment: .top)
            .cornerRadius(16)
        }
        .padding()
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .frame(minWidth: 0,
               idealWidth: .infinity,
               maxWidth: .infinity,
               alignment: .top)
        .cornerRadius(16)
    }
}
