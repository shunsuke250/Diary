//
//  NewDiaryEntryViewController.swift
//  Diary
//
//  Created by 副山俊輔 on 2023/12/01.
//

import UIKit

class NewDiaryEntryViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout()))

    private let diaryDatePicker: UIDatePicker = {
        return $0
    }(UIDatePicker())

    private let addDiaryButton: UIButton = {
        $0.titleLabel?.text = "追加"
        return $0
    }(UIButton())

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

    private func setupConstrains() {
        view.addSubview(collectionView)

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
        2
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        return cell
    }
}
