//
//  ChartListViewController.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/1/25.
//

import UIKit
import SnapKit
import Then

class ChartListViewController: UIViewController {
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 40
        $0.collectionViewLayout = flowLayout
        $0.backgroundColor = .black
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    private let categoryItem: [String] = ["FLO 차트", "해외 소셜 차트", "V컬러링 차트", "국내 발라드", "해외 팝", "국내 댄스/일렉"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubView()
        setConstraints()
    }
    
    func addSubView() {
        view.addSubview(collectionView)
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
    }
}

extension ChartListViewController: UICollectionViewDelegate {}

extension ChartListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as? CategoryCell else {
            return UICollectionViewCell()
        }
        cell.title = categoryItem[indexPath.item]
        return cell
    }
}

extension ChartListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categoryItem[indexPath.item]
        let font = UIFont.systemFont(ofSize: 16)
        let cellWidth = (text as NSString).size(withAttributes: [.font: font]).width + 20
        return CGSize(width: cellWidth, height: 50)
    }
}
