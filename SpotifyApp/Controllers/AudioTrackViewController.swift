//
//  AudioTrackViewController.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 14.2.23..
//

import UIKit

class AudioTrackViewController: UIViewController {
    private let audioTrack: AudioTrack
    
    //MARK: - Init
    init(audioTrack: AudioTrack) {
        self.audioTrack = audioTrack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = audioTrack.name
        
        APICaller.shared.getTracksDetails(for: audioTrack) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
