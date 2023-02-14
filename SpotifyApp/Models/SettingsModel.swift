//
//  SettingsModel.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 13.2.23..
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
