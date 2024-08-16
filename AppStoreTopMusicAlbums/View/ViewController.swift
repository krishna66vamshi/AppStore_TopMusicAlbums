//
//  ViewController.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import UIKit

class ViewController: UIViewController {

    var vm:FeedListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        vm = FeedListViewModel(webServices: NetworkManager())
        
        Task{
            await vm?.callAPI()
        }
        
        vm?.eventHandler = { eventType in
            switch eventType{
            case .loading:
                print("Loading")
            case .stopLoading:
                print("Stop Loading")
            case .error(let err):
                print(err)
            case .dataLoaded:
                print("data Loaded")
                let data = self.vm?.albumsResults
                print(data?.first?.artistName ?? "")
            }
        }
    }
}

