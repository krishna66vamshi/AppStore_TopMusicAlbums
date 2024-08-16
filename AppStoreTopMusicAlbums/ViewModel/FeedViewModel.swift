//
//  FeedViewModel.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import Foundation

class FeedViewModel{
    var artistName:String
    init(result: Result) {
        self.artistName = result.artistName ?? ""
    }
}
