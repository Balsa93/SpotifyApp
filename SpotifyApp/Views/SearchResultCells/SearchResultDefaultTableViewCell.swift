//
//  SearchResultDefaultTableViewCell.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 16.2.23..
//

import UIKit
import SDWebImage

class SearchResultDefaultTableViewCell: UITableViewCell {
    static let identifier = "SearchResultDefaultTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        accessoryType = .disclosureIndicator
        contentView.clipsToBounds = true
        contentView.addSubview(iconImageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 10
        iconImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
        iconImageView.layer.cornerRadius = imageSize / 2
        label.frame = CGRect(x: iconImageView.right + 10, y: 0, width: contentView.width - iconImageView.right - 15, height: contentView.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        iconImageView.image = nil
    }
    
    //MARK: - Public
    public func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        label.text = viewModel.title
        iconImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
