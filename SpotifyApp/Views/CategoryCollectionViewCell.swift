//
//  GenreCollectionViewCell.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 16.2.23..
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    /// Shared instance
    static let identifier = "GenreCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let colors: [UIColor] = [.systemPink, .systemBlue, .systemPurple, .systemOrange, .systemGreen, .systemRed, .systemYellow, .darkGray, .systemTeal, .systemCyan, .systemMint, .systemIndigo]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: contentView.height / 2, width: contentView.width - 20, height: contentView.height / 2)
        imageView.frame = CGRect(x: contentView.width / 2, y: 10, width: contentView.width / 2, height: contentView.height / 2)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        label.text = nil
    }
    
    //MARK: - Public
    public func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        imageView.sd_setImage(with: viewModel.artworkUrl)
        label.text = viewModel.title
        contentView.backgroundColor = colors.randomElement()
    }
}
