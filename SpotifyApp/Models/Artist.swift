//
//  Artist.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 13.2.23..
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let external_urls: [String: String]
    let type: String
}
