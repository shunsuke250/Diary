//
//  NewDiaryEntryViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/12/01.
//

import UIKit

final class NewDiaryEntryViewController: UIViewController {
    private lazy var parentStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView(arrangedSubviews: [customNavigationBar, collectionView]))

    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCollectionViewLayout()
    )

    private let customNavigationBar: UIView = {
        $0.backgroundColor = Color.yellow
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())

    private let toolBar = UIToolbar()

    private let diaryDatePicker: UIDatePicker = {
        $0.datePickerMode = .date
        $0.locale = Locale(identifier: "ja_JP")
        return $0
    }(UIDatePicker())

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "MM月dd日（E）" // "12月21日（水）"の形式
        return formatter
    }()

    private let closeModalViewButton: UIButton = {
        $0.setImage(.init(systemName: "xmark"), for: .normal)
        $0.tintColor = Color.black
        return $0
    }(UIButton())

    private let saveButton: UIButton = {
        $0.setImage(.init(systemName: "checkmark.circle"), for: .normal)
        $0.tintColor = Color.black
        return $0
    }(UIButton())

    @objc func doneButtonPressed() {
        self.view.endEditing(true)
        toolBar.isHidden = true
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        toolBar.isHidden = false
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            toolBar.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(-keyboardSize.height)
            }
            view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        toolBar.snp.updateConstraints {
            $0.bottom.equalToSuperview()
        }
        view.layoutIfNeeded()
    }

    private let actualItemCount = 4
    private let DiaryList: [String] = ["a", "b", "c", "d"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.yellow
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            TextViewCollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        collectionView.collectionViewLayout = createCollectionViewLayout()
        setupConstrains()
        setupActions()
        setupToolBar()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let middleIndex = (1000 / 2) - (1000 / 2) % actualItemCount
        let middleIndexPath = IndexPath(item: middleIndex, section: 0)
        collectionView.scrollToItem(at: middleIndexPath, at: .left, animated: false)
    }

    private func setupConstrains() {
        view.addSubview(parentStackView)
        customNavigationBar.addSubview(closeModalViewButton)
        customNavigationBar.addSubview(diaryDatePicker)
        customNavigationBar.addSubview(saveButton)

        parentStackView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

        customNavigationBar.snp.makeConstraints {
            $0.height.equalTo(44)
        }

        closeModalViewButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(15)
        }

        diaryDatePicker.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        saveButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(15)
        }
    }

    private func setupActions() {
        diaryDatePicker.addAction(UIAction { [weak self] action in
            guard let self = self else { return }
            let selectedDate = self.diaryDatePicker.date
            let dateString = self.dateFormatter.string(from: selectedDate)
            print(dateString)  // 変換された日付を表示
        }, for: .valueChanged)

        closeModalViewButton.addAction(UIAction { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }, for: .touchUpInside)

        saveButton.addAction(UIAction {
            [weak self] _ in

            guard let self else {
                return
            }

            // 現在アクティブなセルのインデックスパスを取得
            let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
            let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)

            guard
                let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint),
                let cell = self.collectionView.cellForItem(at: visibleIndexPath) as? TextViewCollectionViewCell,
                !cell.textContent.isEmpty
            else {
                return
            }

            let selectedDate = self.diaryDatePicker.date
            let content = cell.textContent
            // CoreDataに保存
            DiaryModel.saveDiary(date: selectedDate, content: content)

            self.dismiss(animated: true, completion: nil)
        }, for: .touchUpInside)
    }

    private func setupToolBar() {
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil, action: nil
        )
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneButtonPressed)
        )
        toolBar.items = [spacer, doneButton]
        toolBar.sizeToFit()
        toolBar.isHidden = true

        view.addSubview(toolBar)
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        toolBar.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
        }
    }

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        ))
        let section = NSCollectionLayoutSection(
            group: NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            ), subitems: [item])
        )
        section.orthogonalScrollingBehavior = .paging // 横スクロールを有効にする
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
}

extension NewDiaryEntryViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        1000
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let actualIndex = indexPath.item % actualItemCount // 実際のアイテム数で割った余りを使用
        let data = DiaryList[actualIndex] // 実際のデータ配列からデータを取得
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TextViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(item: data) // セルにデータを設定

        return cell
    }
}

extension NewDiaryEntryViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        // TODO: 縦スクロールで判定される問題を修正する
        print("現在のページ: \(pageIndex)")
    }
}
