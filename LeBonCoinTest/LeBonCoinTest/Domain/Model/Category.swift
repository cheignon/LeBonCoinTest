//
//  Category.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import UIKit

class Category: NSObject {
    var id: Int
    var name: String

    init(apiEntity: CategoryAPIEntity) {
        self.id = apiEntity.id ?? 0
        self.name = apiEntity.name ?? ""
    }
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension Array where Element == Category {
    func name(id: Int) -> String {
        let categoryfound = self.filter { category in
            return category.id == id
        }
        return categoryfound[0].name
    }
}
