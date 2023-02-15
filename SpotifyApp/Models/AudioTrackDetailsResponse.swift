//
//  AudioTrackDetailsResponse.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 14.2.23..
//

import Foundation

struct AudioTrackDetailsResponse: Codable {
    let id: String
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let images: [APIImage]
    let label: String
    let name: String
}
