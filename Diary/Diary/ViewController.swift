//
//  ViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/11/26.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let tableView: UITableView = {
        return $0
    }(UITableView())

    private let addButton: UIButton = {
        $0.setImage(.add, for: .normal)
        $0.contentVerticalAlignment = .fill
        $0.contentHorizontalAlignment = .fill
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: "cell")
        title = "日記一覧"
        setup()
    }

    private func setup() {
        view.addSubview(tableView)
        view.addSubview(addButton)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        addButton.snp.makeConstraints {
            $0.right.bottom.equalToSuperview().inset(40)
            $0.size.equalTo(60)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        10
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DiaryTableViewCell else {
            return UITableViewCell()
        }

        return cell
    }
}
