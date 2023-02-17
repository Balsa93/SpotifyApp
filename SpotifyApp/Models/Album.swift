//
//  Album.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 17.2.23..
//

import Foundation

struct Album: Codable {
    let id: String
    let album_type: String
    let available_markets: [String]
    var images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
