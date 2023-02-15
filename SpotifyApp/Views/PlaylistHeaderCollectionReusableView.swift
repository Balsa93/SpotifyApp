//
//  PlaylistHeaderCollectionReusableView.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 15.2.23..
//

import UIKit
import SDWebImage

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}

final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    /// Shared instance
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
        private let playlistImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "photo")
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            return imageView
        }()
    
        private let nameLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 22, weight: .semibold)
            return label
        }()
    
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.textColor = .secondaryLabel
            label.font = .systemFont(ofSize: 18, weight: .regular)
            label.numberOfLines = 0
            return label
        }()
    
        private let ownerLabel: UILabel = {
            let label = UILabel()
            label.textColor = .secondaryLabel
            label.font = .systemFont(ofSize: 18, weight: .light)
            return label
        }()
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(systemName: "play.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        return button
    }()
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(playlistImageView)
        addSubview(nameLabel)
        addSubview(ownerLabel)
        addSubview(descriptionLabel)
        addSubview(playAllButton)
        
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = height / 1.8
        
        playlistImageView.frame = CGRect(x: (width - imageSize) / 2, y: 20, width: imageSize, height: imageSize)
        nameLabel.frame = CGRect(x: 10, y: playlistImageView.bottom, width: width - 20, height: 44)
        descriptionLabel.frame = CGRect(x: 10, y: nameLabel.bottom, width: width - 20, height: 44)
        ownerLabel.frame = CGRect(x: 10, y: descriptionLabel.bottom, width: width - 20, height: 44)
        playAllButton.frame = CGRect(x: width - 80, y: height - 80, width: 60, height: 60)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
        ownerLabel.text = nil
    }
    
    //MARK: -  @objc private
    @objc private func didTapPlayAll() {
        delegate?.PlaylistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
    
    //MARK: - Public
    public func configure(with viewModel: PlaylistHeaderCollectionReusableViewViewModel) {
        playlistImageView.sd_setImage(with: viewModel.artworkUrl)
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        ownerLabel.text = viewModel.owner
    }
}
