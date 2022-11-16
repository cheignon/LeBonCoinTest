//
//  MainRouter.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 15/11/2022.
//

import UIKit

protocol MainRoutingLogic {
    func routeToDetail()
}

protocol MainDataPassing {
    var object: ListingDataStore? { get }
}

class MainRouter: NSObject, MainDataPassing, MainRoutingLogic {
    weak var viewController: MainViewController?
    var object: ListingDataStore?
    
    func routeToDetail() {
        let destinationViewController = DetailViewController()
        destinationViewController.object = self.object?.object
        self.viewController?.present(destinationViewController, animated: true)
    }
    
}
