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

    private let diaryDatePicker: UIDatePicker = {
        return $0
    }(UIDatePicker())

    private let addDiaryButton: UIButton = {
        $0.titleLabel?.text = "追加"
        return $0
    }(UIButton())

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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let middleIndex = (1000 / 2) - (1000 / 2) % actualItemCount
        let middleIndexPath = IndexPath(item: middleIndex, section: 0)
        collectionView.scrollToItem(at: middleIndexPath, at: .left, animated: false)
    }

    private func setupConstrains() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .red

        collectionView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }

    private func createCollectionViewLayout() -> UICollectionViewLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        ))
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: 5, bottom: 0, trailing: 5
        )
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
