//
//  MusicPlayer.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/10/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import RxGesture

class MusicPlayer: UIView {
    private let songTitleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.text = "Title"
    }
    private let artistLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.text = "Artist"
        $0.textColor = .gray
    }
    private lazy var musicInfoStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        $0.addArrangedSubview(songTitleLabel)
        $0.addArrangedSubview(artistLabel)
    }
    
    private let progressView = UIView().then {
        $0.backgroundColor = .darkGray
    }
    
    private let playButton = UIButton().then {
        var image = UIImage(systemName: "play.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 30))
        $0.setImage(image, for: .normal)
    }
    
    private let prevButton = UIButton().then {
        var image = UIImage(systemName: "backward.end.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 20))
        $0.setImage(image, for: .normal)
    }
    
    private let nextButton = UIButton().then {
        var image = UIImage(systemName: "forward.end.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 20))
        $0.setImage(image, for: .normal)
    }
    
    private lazy var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.addArrangedSubview(prevButton)
        $0.addArrangedSubview(playButton)
        $0.addArrangedSubview(nextButton)
    }
    
    let disposeBag = DisposeBag()
    let musicPlayView = MusicPlayView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        self.rx.tapGesture()
            .withUnretained(self)
            .subscribe(onNext: { owner, sender in
                if sender.state == .changed {
                    owner.showPlayView()
                }
            })
            .disposed(by: disposeBag)
        
        self.rx.panGesture()
            .withUnretained(self)
            .subscribe(onNext: { (owner, sender) in
                guard let superView = owner.superview else { return }
                let translation = sender.translation(in: superView)
                let velocity = sender.velocity(in: superView)
                let scrollDown = velocity.y > 0.0
                
                switch sender.state {
                case .changed:
                    // 스크롤되면 layer의 height를 증가시킨다.
                    // 일정스크롤 이상되면 layer를 hidden 처리
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                        owner.musicPlayView.alpha = 1
                        owner.musicPlayView.frame.origin.y = min(0, owner.musicPlayView.frame.origin.y + translation.y)
                    })
                    break
                case .ended:
                    if scrollDown {
                        owner.hidePlayView()
                    } else {
                        owner.showPlayView()
                    }
                default:
                    break
                }
                
                sender.setTranslation(.zero, in: owner)
            })
            .disposed(by: disposeBag)
    }        
    
    func showPlayView() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let self = self else { return }
            musicPlayView.alpha = 1
            musicPlayView.frame.origin.y = self.frame.origin.y
        })
    }
    
    func hidePlayView() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: { [weak self] in
            guard let self = self else { return }
            musicPlayView.frame.origin.y = 0
        }, completion: { [weak self] _ in
            guard let self = self else { return }
            musicPlayView.alpha = 0
        })
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitView = super.hitTest(point, with: event) {
            return hitView
        }
                
        for subview in subviews {
            let convertedPoint = subview.convert(point, from: self)
            if let hitSubview = subview.hitTest(convertedPoint, with: event) {
                return hitSubview
            }
        }
        return nil
    }
    
    private func setupUI() {
        self.backgroundColor = .background        
        addSubview(musicInfoStack)
        addSubview(progressView)
        addSubview(buttonStackView)
        musicPlayView.alpha = 0
        addSubview(musicPlayView)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
        musicInfoStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        progressView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        buttonStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
        musicPlayView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height)
        }
    }
}
