//
//  MusicPlayView.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/25/25.
//

import UIKit
import SnapKit
import Then
import RxGesture
import RxSwift
import RxCocoa

class MusicPlayView: UIView {

    // MARK: - Properties
    
    // Header
    private let closeButton = UIButton().then {
        var closeImage = UIImage(systemName: "chevron.down")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        closeImage = closeImage?.applyingSymbolConfiguration(.init(pointSize: 20))
        $0.setImage(closeImage, for: .normal)
    }
    
    private let filterButton = UIButton().then {
        var image = UIImage(systemName: "slider.horizontal.3")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 25))
        $0.setImage(image, for: .normal)
    }
    
    private lazy var headerStack = UIStackView().then {
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(filterButton)
        $0.addArrangedSubview(closeButton)
    }
    
    // SongInfo
    private let songTitleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 25)
        $0.textColor = .white
        $0.text = "songName"
    }
    
    private let artistLabel = UILabel().then {
        $0.text = "artist"
    }
    
    private let albumImage = UIImageView().then {
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
    }
    
    private let likeButton = UIButton().then {
        var image = UIImage(systemName: "heart")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 25))
        $0.setImage(image, for: .normal)
    }
    
    private let detailButton = UIButton().then {
        var image = UIImage(systemName: "ellipsis")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 25))
        $0.setImage(image, for: .normal)
        $0.transform = $0.transform.rotated(by: CGFloat(M_PI_2))
    }
    
    private lazy var iconStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.addArrangedSubview(likeButton)
        $0.addArrangedSubview(detailButton)
    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 20
        
        let topStack = UIStackView()
        topStack.axis = .vertical
        topStack.spacing = 10
        topStack.addArrangedSubview(songTitleLabel)
        topStack.addArrangedSubview(artistLabel)
        topStack.alignment = .center
        
        $0.addArrangedSubview(topStack)
        $0.addArrangedSubview(albumImage)
        $0.addArrangedSubview(lyricsLabel)
        $0.addArrangedSubview(iconStack)
    }
    
    private let lyricsLabel = UILabel().then {
        $0.text = "가사가사가사가사가사가"
        $0.textColor = .gray
    }
    
    // BottomStack
    private let instaButton = UIButton().then {
        var instaImage = UIImage(named: "instaImage")
        $0.setImage(instaImage, for: .normal)
    }
    
    private let similarSongButton = UIButton().then {
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.darkGray.cgColor
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 15
        var configuration = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = UIFont.systemFont(ofSize: 12)
        
        configuration.attributedTitle = AttributedString("유사곡", attributes: titleContainer)
        configuration.baseForegroundColor = .white
        
        $0.configuration = configuration
    }
    
    private let playListButton = UIButton().then {
        var image = UIImage(systemName: "music.note.list")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 25))
        $0.setImage(image, for: .normal)
    }
    
    private lazy var bottomStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(instaButton)
        $0.addArrangedSubview(similarSongButton)
        $0.addArrangedSubview(playListButton)
    }
    
    private let seekBar = UIView().then {
        $0.backgroundColor = .darkGray
    }
    
    private let startTimeLabel = UILabel().then {
        $0.text = "00:00"
        $0.textColor = .main
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    private let endTimeLabel = UILabel().then {
        $0.text = "00:00"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 14)
    }
    
    // PlayControll
    private lazy var seekBarStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 2
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        [startTimeLabel, endTimeLabel].forEach { stackView.addArrangedSubview($0) }
        $0.addArrangedSubview(seekBar)
        $0.addArrangedSubview(stackView)
    }
    
    private lazy var playController = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.addArrangedSubview(repeatButton)
        $0.addArrangedSubview(prevSongButton)
        $0.addArrangedSubview(playButton)
        $0.addArrangedSubview(nextSongButton)
        $0.addArrangedSubview(shuffleButton)
    }
    
    private let playButton = UIButton().then {
        var image = UIImage(systemName: "play.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 45))
        $0.setImage(image, for: .normal)
    }
    
    private let nextSongButton = UIButton().then {
        var image = UIImage(systemName: "forward.end.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 30))
        $0.setImage(image, for: .normal)
    }
    
    private let prevSongButton = UIButton().then {
        var image = UIImage(systemName: "backward.end.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 30))
        $0.setImage(image, for: .normal)
    }
    
    private let repeatButton = UIButton().then {
        var image = UIImage(systemName: "repeat.1")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 15))
        $0.setImage(image, for: .normal)
    }
    
    private let shuffleButton = UIButton().then {
        var image = UIImage(systemName: "shuffle")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 15))
        $0.setImage(image, for: .normal)
    }
    
    private let disposeBag = DisposeBag()
    private var initialPosition: CGFloat = .zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        addSubViews()
        setupConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if initialPosition.isZero {
            initialPosition = self.frame.origin.y            
        }
    }
    
    // MARK: - Method
    
    func bind() {
        closeButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (view, _) in
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                    view.frame.origin.y = view.initialPosition
                }, completion: { _ in
                    view.alpha = 0
                })
            })
            .disposed(by: disposeBag)
    }
    
    func addSubViews() {
        self.addSubview(headerStack)
        self.addSubview(stackView)
        self.addSubview(bottomStack)
        self.addSubview(seekBarStack)
        self.addSubview(playController)
    }
    
    func safeAreaTopInset() -> CGFloat {
        let statusHeight = UIApplication.shared.statusBarFrame.size.height
        
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            return topPadding ?? statusHeight
        } else {
            return statusHeight
        }
    }
    
    func setupConstraints() {
        headerStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(safeAreaTopInset() + 10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        albumImage.snp.makeConstraints { make in
            make.width.height.equalTo(240)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        bottomStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(45)
        }
        seekBarStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(playController.snp.top).offset(-20)
        }
        seekBar.snp.makeConstraints { make in
            make.leading.trailing.equalTo(seekBarStack)
            make.height.equalTo(4)
        }
        playController.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bottomStack)
            make.bottom.equalTo(bottomStack.snp.top).offset(-40)
        }
    }
}
