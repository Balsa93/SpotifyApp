//
//  LibraryToggleView.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 17.2.23..
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    enum State {
        case playlist
        case album
    }
    var state: State = .playlist
    
    private let playlistsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 4
        return view
    }()
    
    weak var delegate: LibraryToggleViewDelegate?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistsButton)
        addSubview(albumsButton)
        addSubview(indicatorView)
        
        playlistsButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistsButton.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        albumsButton.frame = CGRect(x: playlistsButton.right, y: 0, width: 100, height: 40)
        layoutIndicator()
    }
    
    //MARK: - @objc private
    @objc private func didTapPlaylists() {
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc private func didTapAlbums() {
        state = .album
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    //MARK: - Private
    private func layoutIndicator() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 0, y: playlistsButton.bottom, width: 100, height: 3)
        case .album:
            indicatorView.frame = CGRect(x: 100, y: playlistsButton.bottom, width: 100, height: 3)
        }
    }
    
    //MARK: - Public
    public func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.layoutIndicator()
        }
    }
}
