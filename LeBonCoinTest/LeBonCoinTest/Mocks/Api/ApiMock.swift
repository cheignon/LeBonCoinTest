//
//  ApiMock.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import Foundation

struct ApiMock: ApiProtocol {
    func getListing(completionHandler: @escaping ApiListingCompletionHandler) {
        let objects = ClassifiedAd.mocks()
        completionHandler(objects,nil)
    }
    
    func getCategory(completionHandler: @escaping ApiCategoryCompletionHandler) {
        let categories = Category.mocks()
        completionHandler(categories,nil)
    }
    
    func getImageFrom(url: String, completionHandler: @escaping ApiImageCompletionHandler) {
        let object = ClassifiedAd.mock()
        var getListingUseCase: GetListingUseCase = GetListingUseCase(repo: ListingImplementation(dataSource: ApiImplementation()))
        getListingUseCase.getImage(url: object.images_url.small, completioHandler: completionHandler)
    }
    
    
}
