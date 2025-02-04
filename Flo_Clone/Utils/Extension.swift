//
//  Extension.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/3/25.
//

import UIKit
import RxSwift
import RxCocoa

extension CALayer {
    func addBorder(_ edges: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in edges {            
            let border = CALayer()
            switch edge {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: frame.width, height: width)
            case .bottom:
                border.frame = CGRect(x: 0, y: frame.height - width, width: frame.width, height: width)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: width, height: frame.height)
            case .right:
                border.frame = CGRect(x: frame.width - width, y: 0, width: width, height: frame.width)
            default:
                break
            }
            border.backgroundColor = color.cgColor
            self.addSublayer(border)
        }
    }
}

extension ObservableType {
    func withPrevious(startWith first: Element) -> Observable<(Element, Element)> {
          return scan((first, first)) { ($0.1, $1) }.skip(1)
      }
}

//extension Reactive where Base: UIPageViewController {
//    var delegate : DelegateProxy<UIPageViewController, UIPageViewControllerDelegate> {
//        return RxUIPageViewControllerDelegateProxy.proxy(for: self.base)
//       }
//}
