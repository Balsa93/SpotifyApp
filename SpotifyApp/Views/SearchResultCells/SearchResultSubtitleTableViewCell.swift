//
//  SearchResultSubtitleTableViewCell.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 16.2.23..
//

import UIKit
import SDWebImage

class SearchResultSubtitleTableViewCell: UITableViewCell {
static let identifier = "SearchResultSubtitleTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        contentView.addSubview(secondaryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.height - 10
        let labelHeight = contentView.height / 2
        iconImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
        label.frame = CGRect(x: iconImageView.right + 10, y: 0, width: contentView.width - iconImageView.right - 15, height: labelHeight)
        secondaryLabel.frame = CGRect(x: iconImageView.right + 10, y: label.bottom, width: contentView.width - iconImageView.right - 15, height: labelHeight)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        secondaryLabel.text = nil
        iconImageView.image = nil
    }
    
    //MARK: - Public
    public func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        secondaryLabel.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
