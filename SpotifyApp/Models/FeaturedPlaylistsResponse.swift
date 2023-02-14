//
//  FeaturedPlaylistsResponse.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 14.2.23..
//

import Foundation

struct FeaturedPlaylistsResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}
