//
//  HTTPClient.swift
//  Hello SwiftUI
//
//  Created by Kimi on 02/08/2021.
//

import Foundation
import Combine

class HTTPClient {
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }

    func performRequest<T: StringProtocol>(method: String, url urlString: String, headers: [String:String]) -> AnyPublisher<Response<T>, Error> {
        
        guard let url = URL(string: urlString) else {
            return Fail<Response<T>, Error>(error: HTTPClientError.invalidURL(url: urlString))
                .eraseToAnyPublisher()
        }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        
        urlRequest.httpMethod = method
        
        for (header, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: header)
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { result -> Response<T> in
                if let value = String(data: result.data, encoding: .utf8) {
                    return Response(value: value as! T, response: result.response)
                }
                throw HTTPClientError.responseError(url: urlString, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum HTTPClientError: Error {
    case invalidURL(url: String)
    case responseError(url: String, response: URLResponse)
}
