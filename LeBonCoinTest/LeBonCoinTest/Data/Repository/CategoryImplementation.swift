//
//  CategoryImplementation.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import Foundation

struct CategoryImplementation: CategoryRepository {
    
    var dataSource: ApiProtocol
    
    func getCategory(completionHandler: @escaping ApiCategoryCompletionHandler) {
        self.dataSource.getCategory(completionHandler: completionHandler)
    }
}
