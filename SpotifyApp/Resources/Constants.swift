//
//  Constants.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 13.2.23..
//

import Foundation

struct Constants {
//    
#warning("AddYourClientID")
    static let clientID = "AddYourClientID"
//    
#warning("AddYourClientSecret")
    static let clientSecret = "AddYourClientSecret"
    static let tokenAPIUrl = "https://accounts.spotify.com/api/token"
//   
    #warning("AddYourRedirectURI")
    static let redirectURI = "AddYourRedirectURI"
    static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    static let baseAPIUrl = "https://api.spotify.com/v1"
}
