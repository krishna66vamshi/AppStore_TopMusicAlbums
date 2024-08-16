//
//  FeedListViewModel.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import Foundation
import UIKit

enum EventHandlingTypes{
    case loading
    case stopLoading
    case dataLoaded
    case error(String)
}

class FeedListViewModel{
    
    
    var eventHandler:((EventHandlingTypes)->()) = {_ in}
    var webServices:WebServicesProtocol?
    var albumsResults = [FeedViewModel]()
    
    init(webServices:WebServicesProtocol) {
        self.webServices = webServices
    }
    
    
    func callAPI() async{
        DispatchQueue.main.async {
            self.eventHandler(.loading)
        }
        do{
            let response = try await webServices?.callAPI(endPoint: Endpoint.getMostPlayedMusic, modelType: MainFeed.self)
            if let response = response,let results = response.feed?.results{
                self.albumsResults = results.map(FeedViewModel.init)
                DispatchQueue.main.async {
                    self.eventHandler(.dataLoaded)
                }
            }
        }catch {
            if let error = error as? NetworkError{
                DispatchQueue.main.async {
                    self.eventHandler(.error(error.errorDescription))
                }
                print(error.errorDescription)
            }
        }
    }
    
    var getNoOfRows:Int{
        return albumsResults.count
    }
    
    func getFeedViewModel(indexPath:IndexPath) -> FeedViewModel{
        return albumsResults[indexPath.row]
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

