//
//  User.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 14.2.23..
//

import Foundation

struct User: Codable {
    let id: String
    let display_name: String
    let external_urls: [String: String]
}
