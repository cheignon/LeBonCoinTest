//
//  GetListingUseCase.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import Foundation

protocol GetListing {
    func getListing(completionHandler: @escaping ApiListingCompletionHandler)
    func getImage(url: String, completioHandler: @escaping ApiImageCompletionHandler )
}

struct GetListingUseCase: GetListing {
    
    
    
    var repo: ListingRepository
    func getListing(completionHandler: @escaping ApiListingCompletionHandler) {
        self.repo.getListing(completionHandler: completionHandler)
    }
    func getImage(url: String, completioHandler: @escaping ApiImageCompletionHandler) {
        self.repo.getImage(url: url, completioHandler: completioHandler)
    }
}
