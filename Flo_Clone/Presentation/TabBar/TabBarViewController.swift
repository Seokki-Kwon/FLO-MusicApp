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
    
    private lazy var tabButtonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    
    var selectedIndex = 0 {
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
        setupTabBar()
        bind()
    }
    private let musicPlayVC = MusicPlayViewController()
    var translateY: CGFloat = 0.0
    // MARK: - Methods
    
    func bind() {
        musicPlayVC.view.frame.origin.y = UIScreen.main.bounds.maxY
        view.addSubview(musicPlayVC.view)
        
        musicPlayer.rx.panGesture()
            .withUnretained(self)
            .subscribe(onNext: { (vc, sender) in
                // viewTranslation값에 제스처로 이동한 x, y값이 저장
                let translation = sender.translation(in: vc.view)
                let velocity = sender.velocity(in: vc.view)
                switch sender.state {
                case .began:
                    // 기존좌표 저장 제스처할때 기존값에 더하기
                    vc.translateY = vc.musicPlayVC.view.frame.origin.y
                case .changed:
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                        // 기존 위치에서 y만큼 이동
                        let newY = max(0, vc.translateY + translation.y)
                        // 0보다 작아지지 않도록
                        vc.musicPlayVC.view.frame.origin.y = newY
                    })
                    
                case .ended:
                    let shouldDismiss = velocity.y > 0
                    if shouldDismiss {
                        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                            vc.musicPlayVC.view.frame.origin.y = UIScreen.main.bounds.maxY
                        })
                    } else {
                        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                            vc.musicPlayVC.view.frame.origin.y = 0
                        })
                    }
                default:
                    break
                }
                
            })
            .disposed(by: disposeBag)
    }
    
    func setViewControllers(_ viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
        setupButton()
        updateView()
    }
    
    private func setupTabBar() {
        view.addSubview(tabBarView)
        view.addSubview(musicPlayer)
        
        tabBarView.snp.makeConstraints {
            $0.bottom.trailing.leading.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        musicPlayer.snp.makeConstraints { make in
            make.bottom.equalTo(tabBarView.snp.top)
            make.leading.trailing.equalToSuperview()
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
