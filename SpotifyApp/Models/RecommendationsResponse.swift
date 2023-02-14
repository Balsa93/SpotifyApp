//
//  RecommendationsResponse.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 14.2.23..
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
