//
//  ApiProtocol.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import UIKit

typealias ApiListingCompletionHandler = ([ClassifiedAd]?, APIServiceError?) -> Void
typealias ApiCategoryCompletionHandler = ([Category]?, APIServiceError?) -> Void
typealias ApiDataCompletionHandler = (Data?, APIServiceError?) -> Void
typealias ApiImageCompletionHandler = (UIImage) -> Void

protocol ApiProtocol {
    func getListing(completionHandler: @escaping  ApiListingCompletionHandler)
    func getCategory(completionHandler: @escaping  ApiCategoryCompletionHandler)
    func getImageFrom(url: String, completionHandler: @escaping ApiImageCompletionHandler)
}
