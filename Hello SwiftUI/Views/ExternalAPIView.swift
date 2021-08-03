//
//  ExternalAPIView.swift
//  Hello SwiftUI
//
//  Created by Kimi on 01/08/2021.
//

import SwiftUI
import Auth0
import AlertToast

struct ExternalAPIView: View {
    
    private(set) var accessToken: String?
    
    private static let httpMethods = ["GET", "POST", "PUT", "DELETE"]
    
    @State private var url = "https://eaceto.free.beeceptor.com/hello-swift/echo"
    
    @State private var httpMethod = httpMethods.first!
    @State private var showCopyToClipboardToast = false
    
    @ObservedObject private var externalAPIViewModel = ExternalAPIViewModel()
    
    @ViewBuilder
    var body: some View {
        if let accessToken = accessToken {
            VStack {
                Button(action: {
                    UIPasteboard.general.string = accessToken
                    showCopyToClipboardToast = true
                }, label: {
                    VStack {
                        VStack {
                            Text("Access Token")
                                .font(.title2)
                            
                            Spacer()
                                .frame(height: 8)
                            
                            Text(accessToken)
                                .font(.subheadline)
                                .lineLimit(4)
                        }
                        .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity)
                        .padding(16)
                        .background(Color(UIColor.secondarySystemGroupedBackground))
                        .cornerRadius(16)
                        
                        Spacer()
                            .frame(height: 8)
                        
                        Text("Tap to copy the complete Access Token")
                            .font(.footnote)
                    }
                })
                
                Spacer()
                    .frame(height: 24)
                    
                    
                VStack{

                    Text("Test Request")
                        .font(.title)
                    
                    VStack {
                        
                        Text("URL")
                            .font(.title3)
                            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
                        
                        TextField("Enter an URL", text: $url)
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                        
                        Divider()
                        
                        Text("HTTP Method")
                            .font(.title3)
                            .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
                        
                        Picker("HTTP Method", selection: $httpMethod) {
                            ForEach(ExternalAPIView.httpMethods, id: \.self) {
                                       Text($0)
                            }
                        }
                       .pickerStyle(SegmentedPickerStyle())
                    }
                    .frame(minWidth: 0, idealWidth: .infinity, maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                       
                    VStack {
                        Button("Try out!") {
                            externalAPIViewModel.performRequest(method: httpMethod, url: url, accessToken: accessToken)
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
            .toast(isPresenting: $showCopyToClipboardToast) {
                AlertToast(displayMode: .hud,
                           type: .complete(Color.purple),
                           title: "Access Token copied!"
                )
            }
            .toast(isPresenting: $externalAPIViewModel.isMakingHTTPRequest) {
                AlertToast(displayMode: .hud,
                           type: .loading,
                           title: "Loading..."
                )
            }
            .toast(isPresenting: $externalAPIViewModel.hasHTTPResponseStatus) {
                var response = "Opsss... there was an error making this request"
                var toastType = AlertToast.AlertType.error(.red)
                
                if let responseValue = externalAPIViewModel.httpResponse?.value {
                    response = responseValue
                    toastType = AlertToast.AlertType.complete(.purple)
                }
                
                return AlertToast(displayMode: .banner(.slide),
                                  type: toastType,
                                  title: response)
            }
            
        }
        else {
            Text("Access token is not defined")
        }
    }
}

struct ExternalAPIView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ExternalAPIView(accessToken: "Test Access Token")
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        
    }
}
