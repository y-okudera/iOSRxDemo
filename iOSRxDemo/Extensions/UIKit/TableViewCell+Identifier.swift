//
//  TableViewCell+Identifier.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return self.className
    }
}
