//
//  DetailedAlbumViewModel.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import UIKit

class ArtistDetailsViewModel{
    
    var feedViewModel :FeedViewModel!
    let webServices:WebServicesProtocol?
    
    init(feedViewModel :FeedViewModel,webServices:WebServicesProtocol) {
        //use userViewModel
        self.feedViewModel = feedViewModel
        self.webServices = webServices
    }
    
    func downloadImageFromCache(imageUrl:String) async -> UIImage?{
        let img = await downloadImageFromAPI(imageUrl)
        return img
    }
    
    @MainActor
    func downloadImageFromAPI(_ imageUrl:String) async -> UIImage?{
        do{
            if let image = try await webServices?.downloadImage(urlStr: imageUrl){
                return image
            }
        }catch {
            if let error = error as? NetworkError{
                print(error.errorDescription)
            }
        }
        return nil
    }
    
}
