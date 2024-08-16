//
//  FeedListViewModel.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import Foundation

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
}

