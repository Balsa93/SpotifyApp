//
//  PlaylistViewController.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 13.2.23..
//

import UIKit

class PlaylistViewController: UIViewController {
    private let playlist: Playlist
    private var collectionView: UICollectionView?
    private var viewModels = [RecommendedTrackCollectionViewCellViewModel]()
    private var tracks = [AudioTrack]()
    public var isOwner = false
    
    //MARK: - Init
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = playlist.name
        
        let collectionView = createCollectionView()
        view.addSubview(collectionView)
        self.collectionView = collectionView
        
        APICaller.shared.getPlaylistDetails(for: playlist) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.tracks = model.tracks.items.compactMap({ $0.track })
                    self?.viewModels = model.tracks.items.compactMap({
                        RecommendedTrackCollectionViewCellViewModel(name: $0.track.name, artistName: $0.track.artists.first?.name ?? "-", artworkUrl: URL(string: $0.track.album?.images.first?.url ?? ""))
                    })
                    self?.collectionView?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
        collectionView.addGestureRecognizer(gesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let collectionView = collectionView {
            collectionView.frame = view.bounds
        }
    }
    
    //MARK: - @objc private
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        let touchPoint = gesture.location(in: collectionView)
        guard let indexPath = collectionView?.indexPathForItem(at: touchPoint) else { return }
        let trackToRemove = tracks[indexPath.row]
        let actionSheet = UIAlertController(title: trackToRemove.name, message: "Would you like to remove \(trackToRemove.name) form the playlist?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        actionSheet.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { [weak self] _ in
            guard let strongSelf = self else { return }
            
            APICaller.shared.removeTrackFromPlaylist(track: trackToRemove, playlist: strongSelf.playlist) { success in
                DispatchQueue.main.async {
                    if success {
                        strongSelf.tracks.remove(at: indexPath.row)
                        strongSelf.viewModels.remove(at: indexPath.row)
                        strongSelf.collectionView?.reloadData()
                    } else {
                        print("Failed to remove")
                    }
                }
            }
        }))
        present(actionSheet, animated: true)
    }
    
    @objc private func didTapShare() {
        guard let url = URL(string: playlist.external_urls["spotify"] ?? "") else { return }
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    //MARK: - Private
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout(section: createSectionLayout())
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(RecommendedTrackCollectionViewCell.self, forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier)
        collectionView.register(PlaylistHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier)
        return collectionView
    }
}

//MARK: - CollectionView
extension PlaylistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier, for: indexPath) as? RecommendedTrackCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let track = tracks[indexPath.row]
        PlaybackPresenter.shared.startPlayback(from: self, track: track)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader, let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier, for: indexPath) as? PlaylistHeaderCollectionReusableView else { return UICollectionReusableView() }
        let headerViewModel = PlaylistHeaderCollectionReusableViewViewModel(name: playlist.name, description: playlist.description, artworkUrl: URL(string: playlist.images.first?.url ?? ""), owner: playlist.owner.display_name)
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    }
}

//MARK: - CollectionView Section layout
extension PlaylistViewController {
    func createSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        return section
    }
}

//MARK: - PlaylistHeaderCollectionReusableViewDelegate
extension PlaylistViewController: PlaylistHeaderCollectionReusableViewDelegate {
    func PlaylistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        PlaybackPresenter.shared.startPlayback(from: self, tracks: tracks)
    }
}
