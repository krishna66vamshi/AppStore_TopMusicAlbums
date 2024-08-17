//
//  DetailsCoordinator.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 17/08/24.
//

import UIKit
import SafariServices

class DetailCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    var feedViewModel: FeedViewModel
    
    init(navigationController: UINavigationController,feedViewModel: FeedViewModel) {
        self.navigationController = navigationController
        self.feedViewModel = feedViewModel
    }
    
    override func start() {
        guard let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: DetailedViewController.reuseID) as? DetailedViewController else {return}
        detailViewController.coordinator = self
        detailViewController.feedVM = feedViewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func openSafari(){
        if let url = URL(string: feedViewModel.artistURL) {
            let safariVC = SFSafariViewController(url: url)
            navigationController.present(safariVC, animated: true, completion: nil)
        }
    }
}
