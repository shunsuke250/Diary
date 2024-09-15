//
//  ViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/11/26.
//

import UIKit
import SnapKit

/// 日記一覧画面
final class DiaryListViewController: UIViewController {
    private let tableView = UITableView()

    private let addButton = UIButton().apply {
        var config = UIButton.Configuration.filled()
        config.image = .init(systemName: "plus")
        config.baseForegroundColor = .appBlack
        config.baseBackgroundColor = .appButtonYellow
        config.buttonSize = .medium
        config.cornerStyle = .capsule
        $0.configuration = config
    }

    private var diaryContents: [DiaryModelObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(DiaryTableViewCell.self)
        title = "日記一覧"
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        diaryContents = DiaryModel.fetchDiary()
        tableView.reloadData()
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

        addButton.addAction(UIAction { [weak self] _ in
            self?.presentNewDiaryEntryViewController()
        }, for: .touchUpInside)
    }

    private func presentNewDiaryEntryViewController() {
        let newDiaryEntryVC = CreateDiaryViewController()
        newDiaryEntryVC.modalPresentationStyle = .fullScreen
        present(newDiaryEntryVC, animated: true, completion: nil)
    }
}

extension DiaryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        diaryContents.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: DiaryTableViewCell.self, for: indexPath)

        let diary = diaryContents[indexPath.row]
        cell.configure(
            date: diary.date,
            day: String(diary.day),
            weekday: diary.weekday,
            content: diary.content
        )

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
