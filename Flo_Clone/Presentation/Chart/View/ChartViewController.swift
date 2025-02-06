//
//  ChartViewController.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/3/25.
//

import UIKit
import SnapKit
import Then

class ChartViewController: UIViewController {
    
    // MARK: - Properties
    
    let text: String
    
    private let selecteAllButton = UIButton().then {
        var buttonConfig = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.systemFont(ofSize: 12)
        
        buttonConfig.attributedTitle = AttributedString("전체선택", attributes: titleContainer)
        buttonConfig.baseForegroundColor = .white
        buttonConfig.image = UIImage(systemName: "checkmark")!.applyingSymbolConfiguration(.init(pointSize: 10))
        buttonConfig.imagePadding = 4.0
        buttonConfig.imagePlacement = .leading
        $0.configuration = buttonConfig
    }
    
    private let desciptionLabel = UILabel().then {
        $0.text = "24시간 집계(10시 기준)"
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textColor = .gray
    }
    
    private let playAllButton = UIButton().then {
        var buttonConfig = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.systemFont(ofSize: 13)
        
        buttonConfig.attributedTitle = AttributedString("전체듣기", attributes: titleContainer)
        buttonConfig.baseForegroundColor = .white
        buttonConfig.image = UIImage(systemName: "play")!.applyingSymbolConfiguration(.init(pointSize: 13))
        buttonConfig.imagePadding = 4.0
        buttonConfig.imagePlacement = .leading
        $0.configuration = buttonConfig
    }
    
    private lazy var filterStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.addArrangedSubview(selecteAllButton)
        $0.addArrangedSubview(desciptionLabel)
        $0.addArrangedSubview(playAllButton)
    }
    private let chartList = UITableView().then {
        $0.backgroundColor = .red
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupConstraints()
    }
    
    // MARK: - Initializer
    
    init(text: String) {
        self.text = text
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func addSubViews() {
        view.addSubview(filterStack)
        view.addSubview(chartList)
    }
    
    func setupConstraints() {
        filterStack.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(40)
        }
        chartList.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(filterStack.snp.bottom)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
