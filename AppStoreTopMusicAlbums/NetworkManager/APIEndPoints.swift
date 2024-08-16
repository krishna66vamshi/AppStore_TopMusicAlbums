//
//  APIEndPoints.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import Foundation

enum Endpoint {
    case getMostPlayedMusic
  

    // Base URL for the API
    var baseURL: String {
        return "https://rss.applemarketingtools.com"
    }

    // Path for each endpoint
    var path: String {
        switch self {
        case .getMostPlayedMusic:
            return "/api/v2/us/music/most-played/10/albums.json"
        }
    }

    // HTTP method for each endpoint
    var method: String {
        switch self {
        case .getMostPlayedMusic:
            return "GET"
        }
    }

    // Full URL combining baseURL and path
    var url: URL? {
        return URL(string: baseURL + path)
    }
}
