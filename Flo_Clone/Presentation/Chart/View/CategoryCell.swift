//
//  CategoryCell.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/1/25.
//

import UIKit
import SnapKit
import Then
import RxSwift

class CategoryCell: UICollectionViewCell {
    var categoryInfo: Category!
    let categoryLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .gray
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    static let identifier = "categoryCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            categoryLabel.textColor = isSelected ? .white : .gray
            if isSelected {
                categoryLabel.layer.addBorder([.bottom], color: .main, width: 2)
            } else {            
                categoryLabel.layer.sublayers?.removeAll()
            }
        }
    }
    
    func setupUI() {
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.center.bottom.top.equalToSuperview()
        }
    }
    
    func configure(_ category: Category) {
        // 초기 UI설정
        categoryLabel.text = category.rawValue
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
