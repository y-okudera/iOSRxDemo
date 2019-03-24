//
//  MusicSearchViewModel.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import RxCocoa
import RxSwift

final class MusicSearchViewModel {
    
    let output: Driver<[Track]>
    
    init(input inputText: String) {
        let iTunesSearchRequest = ITunesSearchRequest(term: inputText)
        let output = APIClient.request(iTunesSearchRequest)
            .map { $0.results }
            .asDriver(onErrorJustReturn: [])
        self.output = output
    }
}
