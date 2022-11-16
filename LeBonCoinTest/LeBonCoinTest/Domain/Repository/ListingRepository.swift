//
//  ListingRepository.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import Foundation
protocol ListingRepository {
    func getListing(completionHandler: @escaping ApiListingCompletionHandler)
    func getImage(url: String, completioHandler: @escaping ApiImageCompletionHandler )
}
