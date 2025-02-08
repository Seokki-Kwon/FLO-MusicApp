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
    var chartList = BehaviorSubject<[Music]>(value: [])
    
    init() {
        getChartList()
    }
    
    func getChartList() {
        let musicArray = [Music(imageThumbnail: UIImage(named: "album1"), rank: 1, songName: "Dash", artistName: "PLAVE"),
                          Music(imageThumbnail: UIImage(named: "album2"), rank: 2, songName: "Drowning", artistName: "WOODZ"),
                          Music(imageThumbnail: UIImage(named: "album3"), rank: 3, songName: "Love Hangover(feat. Dominic Fike)", artistName: "제니(JENNIE) & Dominic Fiek"),
                          Music(imageThumbnail: UIImage(named: "album4"), rank: 4, songName: "Butter Helf (feat. Omooinotake)", artistName: "정한"),
                          Music(imageThumbnail: UIImage(named: "HER"), rank: 5, songName: "민니 (여자)아이들)", artistName: "artist"),
                          Music(imageThumbnail: UIImage(named: "album6"), rank: 6, songName: "Doctor! Doctor!", artistName: "ZEROBASEONE(제로베이스원)"),
                          Music(imageThumbnail: UIImage(named: "album7"), rank: 7, songName: "PYTHON", artistName: "GOT7 (갓세븐)")]
        chartList.on(.next(musicArray))
    }
}
