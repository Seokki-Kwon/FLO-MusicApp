//
//  ChartListViewModel.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/3/25.
//
import RxSwift

final class ChartListViewModel {
    private let disposeBag = DisposeBag()
      
    let categoryItems = BehaviorSubject<[Category]>(value: [
        Category(categoryName: "FLO 차트", isSelected: true),
        Category(categoryName: "해외 소셜 차트", isSelected: false),
        Category(categoryName: "V컬러링 차트", isSelected: false),
        Category(categoryName: "국내 발라드", isSelected: false),
        Category(categoryName: "해외 팝", isSelected: false),
        Category(categoryName: "국내 댄스/일렉", isSelected: false)
    ])
    
    func setCategory(_ category: Category) {
        guard let index = categories.firstIndex(where: {$0.categoryName == category.categoryName}) else { return }
        var newCategory = categories
        newCategory[index].isSelected = true
        categoryItems.onNext(newCategory)
    }
}
