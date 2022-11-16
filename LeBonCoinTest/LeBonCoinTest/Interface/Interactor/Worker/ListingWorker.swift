//
//  ListingWorker.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 11/11/2022.
//

import Foundation

typealias FilterByCategoryCompletionHandler = ([ClassifiedAd], String) -> Void

class ListingWorker {

    var getListingUseCase: GetListingUseCase = GetListingUseCase(repo: ListingImplementation(dataSource: ApiImplementation()))
    var getCategoryUseCase: GetCategoryUseCase = GetCategoryUseCase(repo: CategoryImplementation(dataSource: ApiImplementation()))

    func getListing(completionHandler: @escaping ApiListingCompletionHandler) {
        self.getListingUseCase.getListing(completionHandler: completionHandler)
    }

    func getCategory(completionHandler: @escaping ApiCategoryCompletionHandler) {
        self.getCategoryUseCase.getCategory(completionHandler: completionHandler)
    }

    func getImage(url: String, completionHandler: @escaping ApiImageCompletionHandler) {
        self.getListingUseCase.getImage(url: url, completioHandler: completionHandler)
    }

    func sorteByCategory(id: Int, listing: [ClassifiedAd], categories: [Category], completionHandler: @escaping FilterByCategoryCompletionHandler) {
        let nameCategory = categories.name(id: id)
        let listingFiltered = listing.sortBy(id: id).sorted()
        completionHandler(listingFiltered, nameCategory)
    }

    func filterByText(searchText: String, listing: [ClassifiedAd]) -> [ClassifiedAd] {
        return listing.searchBy(text: searchText).sorted()
    }
}
