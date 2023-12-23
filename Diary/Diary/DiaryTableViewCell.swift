//
//  DiaryTableViewCell.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/11/26.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    private lazy var verticalStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 0
        return $0
    }(UIStackView(arrangedSubviews: [dayLabel, weekdayLabel]))

    private lazy var parentStackView: UIStackView = {
        $0.axis = .horizontal
        $0.alignment = .top
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [verticalStackView, diaryContentLabel]))

    private let dayLabel: UILabel = {
        $0.font = .systemFont(ofSize: 26.0, weight: .regular)
        $0.textColor = Color.black
        $0.text = "26"
        return $0
    }(UILabel())

    private let weekdayLabel: UILabel = {
        $0.font = .systemFont(ofSize: 12.0, weight: .regular)
        $0.textColor = Color.red
        $0.text = "日曜日"
        return $0
    }(UILabel())

    private let diaryContentLabel: UILabel = {
        $0.font = .systemFont(ofSize: 16.0, weight: .regular)
        $0.numberOfLines = 5
        $0.text = "このように文章を\n改行して入力することができます。\nこのアプリはLifeBearの日記機能のUIを参考にして\n作成されています。"
        return $0
    }(UILabel())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        contentView.addSubview(parentStackView)

        parentStackView.snp.makeConstraints {
            $0.top.left.equalToSuperview().offset(10)
            $0.bottom.right.equalToSuperview().inset(10)
        }
    }
}
