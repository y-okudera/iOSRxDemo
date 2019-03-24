//
//  MusicSearchViewController.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

final class MusicSearchViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet private weak var tableView: UITableView!
    private let disposeBag = DisposeBag()
    private var viewModel: MusicSearchViewModel?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setTableViewDelegate()
    }
}

// MARK: - Private func
extension MusicSearchViewController {
    private func initViewModel() {
        
        // TODO: - SearchBarを追加して、検索できるよう変更する
        viewModel = MusicSearchViewModel(input: "秦基博")
        let dataSource = MusicSearchDataSource()
        viewModel?.output.drive(
            tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag
        )
    }
    
    private func setTableViewDelegate() {
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension MusicSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select!!", indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
