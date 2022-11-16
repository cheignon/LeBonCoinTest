//
//  DetailRouter.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 15/11/2022.
//

import Foundation

protocol DetailDataPassing
{
  var object: DetailDataStore? { get }
}

class DetailRouter: NSObject, DetailDataPassing {
    var object: DetailDataStore?
    weak var viewController: DetailViewController?

}

