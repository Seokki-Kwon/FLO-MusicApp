//
//  MusicPlayViewController.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/8/25.
//

import UIKit
import SnapKit
import Then
import RxGesture
import RxSwift
import RxCocoa

class MusicPlayViewController: UIViewController {
    
    // MARK: - Properties
    
    private let songTitleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
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
        image = image?.applyingSymbolConfiguration(.init(pointSize: 20))
        $0.setImage(image, for: .normal)
    }
    
    private let detailButton = UIButton().then {
        var image = UIImage(systemName: "ellipsis")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 20))
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
    
    private let closeButton = UIBarButtonItem().then {
        var closeImage = UIImage(systemName: "chevron.down")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        closeImage = closeImage?.applyingSymbolConfiguration(.init(pointSize: 20))
        $0.image = closeImage
    }
    
    private let lyricsLabel = UILabel().then {
        $0.text = "가사가사가사가사가사가"
        $0.textColor = .gray
    }
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setNavigationItem()
        addSubViews()
        setupConstraints()
        bind()
    }
    
    // MARK: - Method
    
    func bind() {
        closeButton.rx.tap
            .subscribe(onNext: { _ in
                self.navigationController?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func setNavigationItem() {
        var filterImage = UIImage(systemName: "slider.horizontal.3")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        filterImage = filterImage?.applyingSymbolConfiguration(.init(pointSize: 20))
        let filterItem = UIBarButtonItem(image: filterImage, style: .plain, target: nil, action: nil)
                      
        navigationItem.leftBarButtonItem = filterItem
        navigationItem.rightBarButtonItem = closeButton
    }
    
    func addSubViews() {
        view.addSubview(stackView)
    }
        
    func setupConstraints() {
        albumImage.snp.makeConstraints { make in
            make.width.height.equalTo(200)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
        }
    }
}
