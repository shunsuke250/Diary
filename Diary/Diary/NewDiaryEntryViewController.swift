//
//  NewDiaryEntryViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/12/01.
//

import UIKit

class NewDiaryEntryViewController: UIViewController {
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: createCollectionViewLayout()
    )

    private let toolBar = UIToolbar()

    private let diaryDatePicker: UIDatePicker = {
        return $0
    }(UIDatePicker())

    private let addDiaryButton: UIButton = {
        $0.titleLabel?.text = "追加"
        return $0
    }(UIButton())

    @objc func saveButtonTapped() {
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            TextViewCollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
        view.backgroundColor = .white
        setupConstrains()
        collectionView.collectionViewLayout = createCollectionViewLayout()
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
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func setupToolBar() {
        let spacer = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil, action: nil
        )
        let saveButton = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped)
        )
        toolBar.items = [spacer, saveButton]
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

extension NewDiaryEntryViewController: UICollectionViewDelegate {
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
