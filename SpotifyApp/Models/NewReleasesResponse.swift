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
