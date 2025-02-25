//
//  TabBarViewController.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/1/25.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

class TabBarViewController: UIViewController {
    
    // MARK: - Properties
    
    private var viewControllers: [UIViewController] = []
    private var buttons: [UIButton] = []
    private let disposeBag = DisposeBag()
    private let buttonImage: [UIImage?] = [
        UIImage(named: "chartIcon"),
        UIImage(named: "coverImage"),
        UIImage(named: "searchIcon"),
        UIImage(named: "myMusicIcon")
    ]
    
    private let tabBarView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private let musicPlayer = MusicPlayer()
    private let musicPlayView = MusicPlayView()
    
    private lazy var tabButtonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }        
    
    private var selectedIndex = 0 {
        willSet {
            previewsIndex = selectedIndex
        }
        didSet {
            updateView()
        }
    }
    private var previewsIndex = 0
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupTabBar()
        bind()       
    }
    // MARK: - Methods
    
    func addSubViews() {
        view.addSubview(tabBarView)
        view.addSubview(musicPlayer)
        view.addSubview(musicPlayView)
    }
    
    func bind() {
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        setupButton()
        updateView()
    }
    
    private func setupTabBar() {
        tabBarView.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        musicPlayer.snp.makeConstraints { make in
            make.bottom.equalTo(tabBarView.snp.top)
            make.leading.trailing.equalToSuperview()
        }        
        musicPlayView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(musicPlayer)
            make.height.equalTo(view.frame.height)
        }
    }
    
    private func setupButton() {
        tabBarView.addSubview(tabButtonStack)
        
        tabButtonStack.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(tabBarView).offset(12)
            $0.height.equalTo(50)
        }
        
        for (index, vc) in viewControllers.enumerated() {
            let button = UIButton()
            var titleContainer = AttributeContainer()
            titleContainer.font = UIFont.systemFont(ofSize: 12)
            
            button.configurationUpdateHandler = { button in
                var configuration = UIButton.Configuration.plain()
                configuration.attributedTitle = AttributedString(vc.title ?? "", attributes: titleContainer)
                configuration.image = self.buttonImage[index]
                configuration.imagePlacement = .top
                configuration.baseBackgroundColor = .black
                configuration.imagePadding = 10
                switch button.state {
                case .selected:
                    configuration.image = self.buttonImage[index]?.withTintColor(UIColor.white)
                    configuration.baseForegroundColor = .white
                default:
                    configuration.baseForegroundColor = .gray
                }
                
                button.configuration = configuration
            }
            
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            tabButtonStack.addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    func setupView() {
        let selectedVC = viewControllers[selectedIndex]
        
        self.addChild(selectedVC)
        view.insertSubview(selectedVC.view, belowSubview: tabBarView)
        selectedVC.view.frame = view.bounds
        selectedVC.didMove(toParent: self)
    }
    
    private func deleteView() {
        let previousVC = viewControllers[previewsIndex]
        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()
    }
    
    func updateView() {
        deleteView()
        setupView()
        
        buttons.forEach { $0.isSelected = ($0.tag == selectedIndex) }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
}
