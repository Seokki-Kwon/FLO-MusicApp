//
//  ChartViewController.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/3/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class ChartViewController: UIViewController {
    
    // MARK: - Properties
    
    let bag = DisposeBag()
    let chartVM = ChartViewModel()
    
    private let selecteAllButton = UIButton().then {
        var buttonConfig = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.systemFont(ofSize: 14)
        
        buttonConfig.attributedTitle = AttributedString("전체선택", attributes: titleContainer)
        buttonConfig.baseForegroundColor = .white
        buttonConfig.image = UIImage(systemName: "checkmark")!.applyingSymbolConfiguration(.init(pointSize: 10))
        buttonConfig.imagePadding = 4.0
        buttonConfig.imagePlacement = .leading
        $0.configuration = buttonConfig
    }
    
    private let desciptionLabel = UILabel().then {
        $0.text = "24시간 집계(10시 기준)"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .gray
    }
    
    private let playAllButton = UIButton().then {
        var buttonConfig = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.systemFont(ofSize: 14)
        
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
    private let chartTableView = UITableView().then {
        $0.separatorStyle = .none        
    }       
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        chartTableView.register(MusicCell.self, forCellReuseIdentifier: MusicCell.identifier)
        addSubViews()
        setupConstraints()
        bind()
    }
    
    // MARK: - Initializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func bind() {
                
        chartVM.chartList
            .bind(to: chartTableView.rx.items) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: MusicCell.identifier) as! MusicCell
                cell.configure(item)
                return cell
            }
            .disposed(by: bag)
    }
    
    func addSubViews() {
        view.addSubview(filterStack)
        view.addSubview(chartTableView)
    }
    
    func setupConstraints() {
        filterStack.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        chartTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalTo(filterStack.snp.bottom).offset(0)
        }
     
    }

}
