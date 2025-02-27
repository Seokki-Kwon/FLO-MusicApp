//
//  ChartViewModel.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/6/25.
//
import RxSwift
import RxCocoa
import UIKit

final class ChartViewModel {
    
    var musicList = BehaviorSubject<[Music]>(value: [])
    private let chartRespository: ChartRepositoryType = ChartRepository()
    private let disposeBag = DisposeBag()
    private let category: String
    
    init(category: String) {
        self.category = category
        
        chartRespository
            .fetchChart(category: category)
            .map { $0.toDomain() }
            .bind(to: musicList)
            .disposed(by: disposeBag)
    }
    
}
