//
//  Category.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/3/25.
//

enum Category: String, CaseIterable {
    
    case floChart = "FLO 차트"
    case globalSocial = "해외 소셜 차트"
    case vColoring =   "V컬러링 차트"
    case koreanBallad =  "국내 발라드"
    case globalPop = "해외 팝"
    case koreanDance =  "국내 댄스/일렉"
    
    var key: String {
        switch self {
        case .floChart:
            return "FLO_Chart"
        case .globalSocial:
            return "Global_Social_Chart"
        case .vColoring:
            return "V_Coloring_Chart"
        case .koreanBallad:
            return "Korean_Ballad"
        case .globalPop:
            return "Global_Pop"
        case .koreanDance:
            return "Korean_Dance_Electronic"
        }
    }
    
    var index: Int {
        return Category.allCases.firstIndex(of: self)!
    }
}
