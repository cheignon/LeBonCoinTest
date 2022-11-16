//
//  ClassiefiedAd.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import Foundation

extension ClassifiedAd {
    static func mock() -> ClassifiedAd {
        let id: Int = Int.random(in: 1..<999999)
        let title: String = String.random(lenght: 50)
        var category_id: Int = Int.random(in: 1..<10)
        var creation_date: String = Date.randomBetween(start: "2021-10-21", end: Date().dateString())
        var desc: String = String.random(lenght: 450)
        var is_urgent: Bool = Bool.random()
        var images_url: ImagesURL = ImagesURL.mock()
        var price: Float = Float(Int.random(in: 1..<1000))
        var siret: String = String.random(lenght: 13)
        return ClassifiedAd(id: id,
                            title: title,
                            category_id: category_id,
                            creation_date: creation_date,
                            desc: desc,
                            is_urgent: is_urgent,
                            images_url: images_url,
                            price: price,
                            siret: siret)
    }

    static func mocks(length: Int = 300) -> [ClassifiedAd] {
        var securedLength = length
        if securedLength < 0 {
            securedLength = 100
        }
        var objects = [ClassifiedAd]()
        for _ in 0..<securedLength {
            let object = ClassifiedAd.mock()
            objects.append(object)
        }
        return objects
    }
}
