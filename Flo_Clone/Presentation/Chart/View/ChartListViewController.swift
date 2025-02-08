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
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal).then {
        $0.view.backgroundColor = .black
    }
    
    private lazy var subViews: [UIViewController] = {
        let viewControllers = charListVM.categoryItems.value.map { _ in ChartViewController() }
        return viewControllers
    }()
    
    private let charListVM = ChartListViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        addSubView()
        setConstraints()
        bind()
        
    }
    
    // MARK: - Helpers
    
    func bind() {
        
        // 카테고리 변경시 탭UI 변경
        charListVM.categoryItems
            .bind(to: self.collectionView.rx.items) { tableView, row, item in
                let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: IndexPath(row: row, section: 0)) as! CategoryCell
                cell.configure(item)
                
                return cell
            }
            .disposed(by: disposeBag)
        
        // 셀선택시 페이지인덱스 설정
        collectionView.rx.modelSelected(Category.self)
            .withUnretained(self)
            .subscribe(onNext: { (vc, category) in
                vc.charListVM.setPageIndex(category.categoryId)
            })
            .disposed(by: disposeBag)
        
        // 인덱스 변경시 페이지이동
        charListVM.curPageIndex
            .withPrevious(startWith: 0)
            .withUnretained(self)
            .subscribe(onNext: { (vc, arg1) in
                let (prevIndex, curIndex) = arg1
                let direction: UIPageViewController.NavigationDirection = prevIndex < curIndex ? .forward : .reverse
                vc.pageViewController.setViewControllers([vc.subViews[curIndex]], direction: direction, animated: true)
                vc.collectionView.selectItem(at: IndexPath(item: curIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            })
            .disposed(by: disposeBag)
    }
    
    func setupDelegates() {
        pageViewController.dataSource = self
        pageViewController.delegate = self
        collectionView.delegate = self
    }
    
    func addSubView() {
        view.addSubview(collectionView)
        view.addSubview(listDivider)
        view.addSubview(pageViewController.view)
        addChild(pageViewController)
        if let firstVC = subViews.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    func setConstraints() {
        
        // 컬렉션 뷰
        collectionView.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50)
        }
        //
        listDivider.snp.makeConstraints {
            $0.height.equalTo(0.3)
            $0.leading.trailing.equalTo(view)
            $0.top.equalTo(collectionView.snp.bottom)
        }
        
        pageViewController.view.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(collectionView.snp.bottom).offset(1)
        }
    }
}

// MARK: - Extensions

extension ChartListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = charListVM.categoryItems.value[indexPath.item].categoryName
        let font = UIFont.systemFont(ofSize: 16)
        let cellWidth = (text as NSString).size(withAttributes: [.font: font]).width + 20
        return CGSize(width: cellWidth, height: 50)
    }
}

extension ChartListViewController:  UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = subViews.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        
        return subViews[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = subViews.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == subViews.count {
            return nil
        }
        return subViews[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = subViews.firstIndex(of: currentVC) else { return }
        charListVM.setPageIndex(currentIndex)
    }
}
