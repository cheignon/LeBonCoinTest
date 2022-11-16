//
//  Category.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import Foundation

extension Category {
    
    public static func mock() -> Category {
        return Category(id: 1, name: "Voiture")
    }
    
    public static func mocks() -> [Category] {
      
        var categories = [Category]()
        for index in 1..<10 {
            let name = String.random(lenght: 15)
            let category = Category(id: index, name: name)
            categories.append(category)
        }
        return categories
    }
}
