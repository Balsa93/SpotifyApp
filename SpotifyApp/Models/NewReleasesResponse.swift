//
//  NewReleasesResponse.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 14.2.23..
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: AlbumResponse
}

struct AlbumResponse: Codable {
    let items: [Album]
}

struct Album: Codable {
    let id: String
    let album_type: String
    let available_markets: [String]
    let images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
}
