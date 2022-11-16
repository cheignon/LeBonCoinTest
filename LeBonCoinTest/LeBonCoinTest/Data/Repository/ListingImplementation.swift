//
//  ListingImplementation.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import Foundation

struct ListingImplementation: ListingRepository {

    var dataSource: ApiProtocol
    func getListing(completionHandler: @escaping ApiListingCompletionHandler) {
        self.dataSource.getListing(completionHandler: completionHandler)
    }
    func getImage(url: String, completioHandler: @escaping ApiImageCompletionHandler) {
        self.dataSource.getImageFrom(url: url, completionHandler: completioHandler)
    }
}
