//
//  UserProfile.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 13.2.23..
//

import Foundation

/// UserProfile
struct UserProfile: Codable {
    let id: String
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let product: String
    let images: [APIImage]
}
