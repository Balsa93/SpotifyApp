//
//  AlbumViewController.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 14.2.23..
//

import UIKit

class AlbumViewController: UIViewController {
    private let album: Album
    
    //MARK: - Init
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = album.name
        
        APICaller.shared.getAlbumDetails(for: album) { result in
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
