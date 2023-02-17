//
//  Category.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 16.2.23..
//

import Foundation

struct Category: Codable {
    let id: String
    let name: String
    let icons: [APIImage]
}

struct Categories: Codable {
    let items: [Category]
}
