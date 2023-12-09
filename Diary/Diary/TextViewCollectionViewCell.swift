//
//  TextViewCollectionViewCell.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/12/09.
//

import UIKit

class TextViewCollectionViewCell: UICollectionViewCell {
    private let textView: UITextView = {
        $0.text = "本文"
        $0.font = .systemFont(ofSize: 16.0, weight: .regular)
        $0.textColor = Color.black
        $0.backgroundColor = .cyan
        return $0
    }(UITextView())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(textView)

        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func configure(item: String) {
        textView.text = item
    }
}
