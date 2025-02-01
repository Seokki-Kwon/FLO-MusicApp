//
//  CategoryCell.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/1/25.
//

import UIKit
import SnapKit
import Then

class CategoryCell: UICollectionViewCell {
    var title: String = "" {
        didSet {
            categoryLabel.text = title
        }
    }
    let categoryLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .white
    }
    
    static let identifier = "categoryCell"
    
    override init(frame: CGRect) {
           super.init(frame: frame)        
           setupUI()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(categoryLabel)
        
        categoryLabel.snp.makeConstraints {            
            $0.center.equalToSuperview()            
        }
    }
}
