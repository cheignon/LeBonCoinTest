//
//  CategoryRepository.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import Foundation
protocol CategoryRepository {
    func getCategory(completionHandler: @escaping ApiCategoryCompletionHandler)
}
