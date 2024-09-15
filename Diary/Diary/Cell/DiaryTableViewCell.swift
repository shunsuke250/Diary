//
//  DiaryTableViewCell.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/11/26.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    private let dayLabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 26.0, weight: .regular)
        $0.textColor = .appBlack
        $0.text = "26"
    }

    private let weekdayLabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 12.0, weight: .regular)
        $0.textColor = .appRed
        $0.text = "日曜日"
    }

    private let diaryContentLabel = UILabel().apply {
        $0.font = .systemFont(ofSize: 16.0, weight: .regular)
        $0.numberOfLines = 5
        $0.text = "このように文章を\n改行して入力することができます。\nこのアプリはLifeBearの日記機能のUIを参考にして\n作成されています。"
    }

    private lazy var verticalStackView = UIStackView(arrangedSubviews: [
        dayLabel,
        weekdayLabel
    ]).apply {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 0
    }

    private lazy var parentStackView = UIStackView(arrangedSubviews: [
        verticalStackView,
        diaryContentLabel
    ]).apply {
        $0.axis = .horizontal
        $0.alignment = .top
        $0.spacing = 10
    }

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

        verticalStackView.snp.makeConstraints {
            $0.width.equalTo(40)
        }
    }

    func configure(
        date: Date,
        day: String,
        weekday: Weekday,
        content: String
    ) {
        dayLabel.attributedText = .init(
            string: day,
            attributes: [
                .foregroundColor: weekday.holidayColor(for: date)
            ]
        )
        weekdayLabel.attributedText = NSAttributedString(
            string: "\(weekday.displayName)曜日",
            attributes: [
                .foregroundColor: weekday.holidayColor(for: date)
            ]
        )
        diaryContentLabel.text = content
    }
}
