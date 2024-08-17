//
//  Coordintaor.swift
//  AppStoreTopMusicAlbums
//
//  Created by Hyper Thread Solutions Pvt Ltd on 17/08/24.
//

import Foundation
import UIKit

protocol Coordinator:AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    func start() {
        // This method should be overridden by subclasses
    }
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}


class MainCoordinator: BaseCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.reuseID) as? ViewController else {return}
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func goToDetail(feedViewModel: FeedViewModel) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController,feedViewModel: feedViewModel)
        addChildCoordinator(detailCoordinator)
        detailCoordinator.start()
    }
}


