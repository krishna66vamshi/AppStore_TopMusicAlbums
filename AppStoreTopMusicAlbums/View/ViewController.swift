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
    weak var coordinator: MainCoordinator?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelUI()
    }
    
    func setupViewModelUI(){
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
                self.showAlert(message: err)
            case .dataLoaded:
                print("data Loaded")
                let data = self.vm?.albumsResults
                print(data?.first?.artistName ?? "")
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    func showAlert(message:String){
        let alertVC = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alertVC.addAction(action)
        present(alertVC, animated: true)
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.getNoOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.reuseID, for: indexPath) as? AlbumTableViewCell else { return .init() }
        
        if let feedViewModel = vm?.getFeedViewModel(indexPath: indexPath){
            cell.configureCell(feed: feedViewModel)
            if let vm = vm{
                cell.loadImage(vm: vm)
            }
        }
        
        cell.callBack = { [weak self] in
            guard let self = self else { return  }
            self.moveToDetailsVC(indexPath: indexPath)
        }
        
        return cell
    }
    
    func moveToDetailsVC(indexPath:IndexPath){
        if let feedViewModel = self.vm?.getFeedViewModel(indexPath: indexPath){
            coordinator?.goToDetail(feedViewModel: feedViewModel)
        }
    }
}

extension ViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moveToDetailsVC(indexPath: indexPath)
    }
}
