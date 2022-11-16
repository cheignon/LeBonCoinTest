//
//  ClassifiedAd.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import UIKit

class ClassifiedAd: NSObject {
    var id: Int
    var title: String
    var category_id: Int
    var creation_date: String
    var desc: String
    var is_urgent: Bool
    var images_url: ImagesURL
    var price: Float
    var siret: String
    var dateObject: Date {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter.date(from: self.creation_date) ?? Date()
        }
    }

    init(id: Int, title: String, category_id: Int, creation_date: String,
                  desc: String, is_urgent: Bool, images_url: ImagesURL, price: Float, siret: String) {
        self.id = id
        self.title = title
        self.category_id = category_id
        self.creation_date = creation_date
        self.desc = desc
        self.is_urgent = is_urgent
        self.images_url = images_url
        self.price = price
        self.siret = siret
    }
    required init(apiEntity: ClassifiedAdApiEntity) {
        self.id = apiEntity.id ?? 0
        self.title = apiEntity.title ?? ""
        self.category_id = apiEntity.category_id ?? 0
        self.creation_date = apiEntity.creation_date ?? ""
        self.desc = apiEntity.description ?? ""
        self.is_urgent = apiEntity.is_urgent ??  false
        self.images_url = ImagesURL(apiEntity: apiEntity.images_url ?? ImagesURLApiEntity())
        self.price = apiEntity.price ?? 0.0
        self.siret = apiEntity.siret ?? ""
    }

}

extension Array where Element == ClassifiedAd {
    func sorted() -> [ClassifiedAd] {

        // recuperation des trucs urgent
        let urgent = self.filter {classifiedAd in
            return classifiedAd.is_urgent
        }

        // recuperation des trucs non urgent
        let notUrgent = self.filter {classifiedAd in
            return !classifiedAd.is_urgent
        }

        // trie par date des trucs urgent
        let urgentSorted = urgent.sorted(by: { $0.dateObject.compare($1.dateObject) == .orderedDescending })

        // trie par date des trucs non urgent
        let notUrgentSorted = notUrgent.sorted(by: { $0.dateObject.compare($1.dateObject) == .orderedDescending })

        // creation d'un tableau avec d'abord les truc urgent trié puis les truc non urgent non trié
        // je pense qu'il est possible d'optimisé cela par un NSSet
        var sortedClassifiedAd = [ClassifiedAd]()
        sortedClassifiedAd.append(contentsOf: urgentSorted)
        sortedClassifiedAd.append(contentsOf: notUrgentSorted)
        return sortedClassifiedAd
    }

    func sortBy(id: Int) -> [ClassifiedAd] {
        let filtered = self.filter { classifiedAd in
            return classifiedAd.category_id == id
        }
        return filtered.sorted()
    }

    func searchBy(text: String) -> [ClassifiedAd] {
        let filtered = self.filter { classifiedAd in
            return classifiedAd.description.contains(text) || classifiedAd.title.contains(text)
        }
        return filtered
    }
}
