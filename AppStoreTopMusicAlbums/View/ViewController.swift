//
//  ViewController.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 16/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var vm:FeedListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm = FeedListViewModel(webServices: NetworkManager())
        
        Task{
            await vm?.callAPI()
        }
        
        vm?.eventHandler = { eventType in
            switch eventType{
            case .loading:
                self.activityIndicator.startAnimating()
                print("Loading")
            case .stopLoading:
                self.activityIndicator.stopAnimating()
                print("Stop Loading")
            case .error(let err):
                print(err)
                self.activityIndicator.stopAnimating()
            case .dataLoaded:
                print("data Loaded")
                let data = self.vm?.albumsResults
                print(data?.first?.artistName ?? "")
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.getNoOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell", for: indexPath) as? AlbumTableViewCell else { return .init() }
        
        if let feedViewModel = vm?.getFeedViewModel(indexPath: indexPath){
            cell.configureCell(feed: feedViewModel)
            if let vm = vm{
                cell.loadImage(vm: vm)
            }
        }
        
        cell.callBack = {
            guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController else {return}
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        return cell
    }
}

extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
