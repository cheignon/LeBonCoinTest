//
//  GetCategoryUseCase.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import Foundation

protocol GetCategory {
    func getCategory(completionHandler: @escaping ApiCategoryCompletionHandler)
}

struct GetCategoryUseCase: GetCategory {

    var repo: CategoryRepository
    func getCategory(completionHandler: @escaping ApiCategoryCompletionHandler) {
        self.repo.getCategory(completionHandler: completionHandler)
    }

}
