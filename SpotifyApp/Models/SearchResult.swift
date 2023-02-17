//
//  SearchResult.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 16.2.23..
//

import Foundation

enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
