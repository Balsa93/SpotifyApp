//
//  TitleHeaderCollectionReusableView.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 15.2.23..
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    /// Shared instance
    static let identifier = "TitleHeaderCollectionReusableView"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 15, y: 0, width: width - 30, height: height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    //MARK: - Public
    public func configure(with title: String) {
        titleLabel.text = title
    }
}
