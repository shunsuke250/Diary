//
//  NewDiaryEntryViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/12/01.
//

import UIKit

class NewDiaryEntryViewController: UIViewController {
    private var pageViewController: UIPageViewController!

    private let diaryInputTextView: UITextView = {
        $0.backgroundColor = .cyan
        $0.text = "ここに日記を入力"
        return $0
    }(UITextView())

    private let diaryDatePicker: UIDatePicker = {
        return $0
    }(UIDatePicker())

    private let addDiaryButton: UIButton = {
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
