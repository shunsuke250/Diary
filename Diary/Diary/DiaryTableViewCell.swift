//
//  DiaryTableViewCell.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/11/26.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    private let dateLabel: UILabel = {
        $0.font = .systemFont(ofSize: 14.0)
        $0.textColor = Color.black
        $0.text = "text"
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
        addSubview(dateLabel)

        dateLabel.snp.makeConstraints {
            $0.left.top.equalToSuperview()
        }
    }
}
