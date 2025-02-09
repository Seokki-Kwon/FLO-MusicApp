//
//  MusicPlayer.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/10/25.
//

import UIKit
import SnapKit
import Then

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .background
        
        addSubview(musicInfoStack)
        addSubview(progressView)
        addSubview(buttonStackView)
        
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
    }
}
