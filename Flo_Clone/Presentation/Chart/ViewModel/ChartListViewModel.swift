//
//  ChartListViewModel.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/3/25.
//
import RxSwift
import RxCocoa

final class ChartListViewModel {
    private let disposeBag = DisposeBag()
      
    let categoryItems = BehaviorRelay<[Category]>(value: [
        Category(categoryId: 0, categoryName: "FLO 차트"),
        Category(categoryId: 1, categoryName: "해외 소셜 차트"),
        Category(categoryId: 2, categoryName: "V컬러링 차트"),
        Category(categoryId: 3, categoryName: "국내 발라드"),
        Category(categoryId: 4, categoryName: "해외 팝"),
        Category(categoryId: 5, categoryName: "국내 댄스/일렉")
    ])
    let curPageIndex = BehaviorSubject<Int>(value: 0)
    
    func setPageIndex(_ index: Int) {
        curPageIndex.on(.next(index))
    }
}
