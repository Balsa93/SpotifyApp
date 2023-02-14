//
//  Playlist.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 13.2.23..
//

import Foundation

struct Playlist: Codable {
    let id: String
    let description: String
    let external_urls: [String: String]
    let name: String
    let images: [APIImage]
    let owner: User
}
