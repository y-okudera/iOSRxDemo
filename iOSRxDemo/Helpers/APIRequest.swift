//
//  APIRequest.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Alamofire

// MARK: - Protocol
protocol APIRequest {
    
    associatedtype Response: Decodable
    
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: [String: Any] { get }
    var httpHeaderFields: [String: String] { get }
    
    /// URLRequestを生成する
    func makeURLRequest(needURLEncoding: Bool) -> URLRequest
}

// MARK: - Default implementation
extension APIRequest {
    
    var baseURL: URL {
        guard let url = URL(string: "https://example.com") else {
            fatalError("baseURL is nil.")
        }
        return url
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/path"
    }
    
    var parameters: [String: Any] {
        return [:]
    }
    
    var httpHeaderFields: [String: String] {
        return [:]
    }
    
    func makeURLRequest(needURLEncoding: Bool = true) -> URLRequest {
        
        let endPoint = baseURL.absoluteString + path
        
        // String to URL
        guard let url = URL(string: endPoint) else {
            fatalError("Endpoint is invalid. endPoint:\(endPoint)")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = httpHeaderFields
        urlRequest.timeoutInterval = 30
        
        if !needURLEncoding {
            return urlRequest
        }
        
        // encode
        do {
            urlRequest = try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
            return urlRequest
        } catch {
            fatalError("An error occurred in encoding. URLRequest:\(urlRequest)")
        }
    }
}
