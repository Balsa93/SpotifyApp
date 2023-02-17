//
//  PlaybackPresenter.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 16.2.23..
//

import UIKit

protocol PlaybackPresenterDataSource: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageUrl: URL? { get }
}

final class PlaybackPresenter {
    /// Shared instance
    static let shared = PlaybackPresenter()
    
    //MARK: - Public
    public func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    public func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true)
    }
}

//MARK: - PlaybackPresenterDataSource
extension PlaybackPresenter: PlaybackPresenterDataSource {
    var songName: String? {
        return nil
    }
    
    var subtitle: String? {
        return nil
    }
    
    var imageUrl: URL? {
        return nil
    }
}
