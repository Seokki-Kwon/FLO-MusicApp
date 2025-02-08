//
//  MusicCell.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/6/25.
//

import UIKit
import SnapKit
import Then

class MusicCell: UITableViewCell {
    static let identifier = "MusicCell"
    var music: Music!
    private let albumImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
    }
    
    private let rankLabel = UILabel().then {
        $0.textColor = .white
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private let songTitleLabel = UILabel()
    
    private let artistLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
    }
    
    private let playButton = UIButton().then {
        var image = UIImage(systemName: "play.fill")?.withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        image = image?.applyingSymbolConfiguration(.init(pointSize: 20))
        $0.setImage(image, for: .normal)
    }
    
    private lazy var chartStack = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .firstBaseline
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(songTitleLabel)
        stackView.addArrangedSubview(artistLabel)
        stackView.alignment = .leading
        $0.addArrangedSubview(rankLabel)
        $0.addArrangedSubview(stackView)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
    func setupUI() {
        contentView.addSubview(albumImage)
        contentView.addSubview(chartStack)
        contentView.addSubview(playButton)
        
        self.selectionStyle = .none
        contentView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalToSuperview()
        }
        albumImage.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
        }
        playButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
        }
        chartStack.snp.makeConstraints { make in
            make.leading.equalTo(albumImage.snp.trailing).offset(20)
            make.trailing.equalTo(playButton.snp.leading).offset(-20)
            make.centerY.equalToSuperview()
        }
        
    }
    
    func configure(_ music: Music) {
        self.albumImage.image = music.imageThumbnail
        self.rankLabel.text = "\(music.rank)"
        self.songTitleLabel.text = music.songName
        self.artistLabel.text = music.artistName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
