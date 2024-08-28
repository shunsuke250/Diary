//
//  ViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/11/26.
//

import UIKit
import SnapKit

/// 日記一覧画面
final class ViewController: UIViewController {
    private let tableView = UITableView()

    private let addButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.image = .init(systemName: "plus")
        config.baseForegroundColor = .appBlack
        config.baseBackgroundColor = .appButtonYellow
        config.buttonSize = .medium
        config.cornerStyle = .capsule
        $0.configuration = config
        return $0
    }(UIButton())

    private var diaryContents: [DiaryModelObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DiaryTableViewCell.self, forCellReuseIdentifier: "cell")
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
        let newDiaryEntryVC = NewDiaryEntryViewController()
        newDiaryEntryVC.modalPresentationStyle = .fullScreen
        present(newDiaryEntryVC, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? DiaryTableViewCell else {
            return UITableViewCell()
        }
        let diary = diaryContents[indexPath.row]
        cell.configure(day: String(diary.day), weekday: diary.weekday, content: diary.content)

        return cell
    }

    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
