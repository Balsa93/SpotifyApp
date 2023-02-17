//
//  PlayerViewController.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 13.2.23..
//

import UIKit
import SDWebImage

protocol PlaybackPresenterDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    weak var delegate: PlaybackPresenterDelegate?
    weak var dataSource: PlaybackPresenterDataSource?
    private let controlsView = PlayerControlsView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        
        controlsView.delegate = self
        
        setUpBarButtons()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
        controlsView.frame = CGRect(x: 10, y: imageView.bottom + 10, width: view.width - 20, height: view.height - imageView.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15)
    }
    
    //MARK: - @objc private
    @objc private func didTapClose() {
        dismiss(animated: true)
    }
    
    @objc private func didTapAction() {
        
    }
    
    //MARK: - Private
    private func setUpBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageUrl)
        controlsView.configure(with: PlayerControlsViewViewModel(title: dataSource?.songName, subtitle: dataSource?.subtitle))
    }
    
    //MARK: - Public
    public func refreshUI() {
        configure()
    }
}

//MARK: - PlayerControlsViewDelegate
extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
    
    func playerControlsViewDidTapPlayPauseButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControlsViewDidTapForwardButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapForward()
    }
    
    func playerControlsViewDidTapBackwardsButton(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapBackward()
    }
}
