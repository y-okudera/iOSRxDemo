//
//  MusicSearchDataSource.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class MusicSearchDataSource: NSObject {
    
    typealias Element = [Track]
    var itemModels: Element = []
}

// MARK: - UITableViewDataSource
extension MusicSearchDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MusicTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.element = itemModels[indexPath.row]
        return cell
    }
}

// MARK: - RxTableViewDataSourceType
extension MusicSearchDataSource: RxTableViewDataSourceType {
    
    func tableView(_ tableView: UITableView, observedEvent: Event<[Track]>) {
        Binder(self) { dataSource, element in
            dataSource.itemModels = element
            tableView.reloadData()
        }
        .on(observedEvent)
    }
}
