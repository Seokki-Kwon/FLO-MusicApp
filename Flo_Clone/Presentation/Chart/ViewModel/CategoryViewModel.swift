//
//  CategoryViewModel.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/27/25.
//

import RxSwift
import RxCocoa

final class CategoryViewModel {
    private let disposeBag = DisposeBag()
      
    let categoryItems = BehaviorRelay<[Category]>(value: Category.allCases)
    let curPageIndex = BehaviorSubject<Int>(value: 0)
    
    func setPageIndex(_ index: Int) {
        curPageIndex.on(.next(index))
    }
}
