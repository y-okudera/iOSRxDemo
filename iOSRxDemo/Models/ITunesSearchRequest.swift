//
//  ITunesSearchRequest.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Alamofire

struct ITunesSearchRequest: APIRequest {
    
    typealias Response = Tracks
    
    init(term: String) {
        self.term = term
    }
    
    var term: String
    
    var baseURL: URL {
        guard let url = URL(string: "https://itunes.apple.com") else {
            fatalError("ITunesSearchRequest baseURL is nil.")
        }
        return url
    }
    var method = HTTPMethod.get
    var path = "/search"
    var parameters: [String: Any] {
        return [
            "term": term,
            "country": "JP",
            "lang": "ja_jp",
            "media": "music"
        ]
    }
}
