//
//  ITunesSearchResponse.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

struct Tracks: Codable {
    var resultCount = 0
    var results = [Track]()
}

struct Track: Codable {
    var trackId = 0
    var trackName = ""
    var artistName = ""
    var artworkUrl100 = ""
}
