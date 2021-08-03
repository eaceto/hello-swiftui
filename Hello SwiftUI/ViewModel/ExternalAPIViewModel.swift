//
//  ExternalAPIViewModel.swift
//  Hello SwiftUI
//
//  Created by Kimi on 02/08/2021.
//

import Foundation
import Combine

class ExternalAPIViewModel: ObservableObject {
 
    @Published private(set) var httpResponse: HTTPClient.Response<String>? = nil
    @Published var hasHTTPResponseStatus = false
    @Published var isMakingHTTPRequest = false
        
    private var disposables = Set<AnyCancellable>()
    
    func performRequest(method: String, url: String, accessToken: String) {
        hasHTTPResponseStatus = false
        isMakingHTTPRequest = true
        
        let cancellable = HTTPClient()
            .performRequest(
                method: method,
                url: url,
                headers: [
                    "Authorization": accessToken
                ]
            )
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in
                self.hasHTTPResponseStatus = true
                self.isMakingHTTPRequest = false
            },
            receiveValue: {
                self.httpResponse = $0
            })
        
        disposables.insert(cancellable)
    }
    
    func cancel() {
        disposables.forEach {
            $0.cancel()
        }
    }
}
