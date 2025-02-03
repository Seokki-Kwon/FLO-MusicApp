//
//  ChartListViewController.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/1/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class ChartListViewController: UIViewController {
    
    // MARK: - Properties
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 40
        $0.collectionViewLayout = flowLayout
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .black
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    }
    
    private let listDivider = UIView().then {
        $0.backgroundColor = .darkGray
    }
    
    private let charListVM = ChartListViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
//        collectionView.dataSource = self
        
        addSubView()
        setConstraints()
        bind()
    }
    
    // MARK: - Helpers
    
    func bind() {
        charListVM.categoryItems
            .bind(to: self.collectionView.rx.items) { tableView, row, item in
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: IndexPath(row: row, section: 0)) as! CategoryCell
                cell.configure(item)
                return cell
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Category.self)
            .subscribe(onNext: { category in
                self.charListVM.setCategory(category)
            })
            .disposed(by: disposeBag)
    }
    
    func addSubView() {
        view.addSubview(collectionView)
        view.addSubview(listDivider)
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        
        listDivider.snp.makeConstraints {
            $0.height.equalTo(0.3)
            $0.leading.trailing.equalTo(view)
            $0.top.equalTo(collectionView.snp.bottom)
        }
    }
}

// MARK: - Extensions

extension ChartListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = categories[indexPath.item].categoryName
        let font = UIFont.systemFont(ofSize: 16)
        let cellWidth = (text as NSString).size(withAttributes: [.font: font]).width + 20
        return CGSize(width: cellWidth, height: 50)
    }
}
