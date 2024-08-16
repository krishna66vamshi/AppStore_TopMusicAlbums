//
//  FeedViewModel.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import Foundation

class FeedViewModel{
    var artistName,releaseDate:String
    var artworkUrl100:String

    init(result: Result) {
        self.artistName = result.artistName ?? ""
        self.artworkUrl100 = result.artworkUrl100 ?? ""
        self.releaseDate = result.releaseDate ?? ""

    }
}
