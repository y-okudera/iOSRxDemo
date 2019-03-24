//
//  UITableView+DequeueReusableCell.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 再利用するセルのインスタンスを生成
    ///
    /// e.g.
    /// ```
    /// let cell: TheCell = tableView.dequeueReusableCell(for: indexPath)
    /// ```
    ///
    /// - Warning: Identifier must be the same as the class name.
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Custom tableViewCell instantiate failure.")
        }
        return cell
    }
}
