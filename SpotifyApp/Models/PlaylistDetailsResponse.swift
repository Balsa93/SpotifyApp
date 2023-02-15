//
//  PlaylistDetailsResponse.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 14.2.23..
//

import Foundation

struct PlaylistDetailsResponse: Codable {
    let id: String
    let description: String
    let external_urls: [String: String]
    let images: [APIImage]
    let tracks: PlaylistTracksResponse
    let name: String
}

struct PlaylistTracksResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
