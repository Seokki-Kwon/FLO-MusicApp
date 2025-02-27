//
//  ChartRepository.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/27/25.
//

import RxSwift

protocol ChartRepositoryType {
    func fetchChart(category: String) -> Observable<[MusicDto]>
}

final class ChartRepository: ChartRepositoryType {
    func fetchChart(category: String) -> RxSwift.Observable<[MusicDto]> {
        APIManager.shared.request(urlConvertible: ChartAPI.fetchCategory(category: category))
    }
}
