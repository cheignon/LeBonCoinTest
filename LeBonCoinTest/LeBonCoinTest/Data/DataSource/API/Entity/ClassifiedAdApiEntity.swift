//
//  ClassifiedAdApiEntity.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import Foundation

struct ClassifiedAdApiEntity {
    
    var id: Int?
    var title: String?
    var category_id: Int?
    var creation_date: String?
    var description: String?
    var is_urgent: Bool?
    var images_url: ImagesURLApiEntity?
    var price: Float?
    var siret: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case category_id
        case creation_date
        case description
        case is_urgent
        case images_url
        case price
        case siret
    }
    
  
}

extension ClassifiedAdApiEntity: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        title = try? values.decode(String.self, forKey: .title)
        category_id = try? values.decode(Int.self, forKey: .category_id)
        creation_date = try? values.decode(String.self, forKey: .creation_date)
        description = try? values.decode(String.self, forKey: .description)
        is_urgent = try? values.decode(Bool.self, forKey: .is_urgent)
        images_url = try? values.decode(ImagesURLApiEntity.self, forKey: .images_url)
        price = try? values.decode(Float.self, forKey: .price)
        siret = try? values.decode(String.self, forKey: .siret)

    }
}


extension ClassifiedAdApiEntity: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(category_id, forKey: .category_id)
        try container.encode(creation_date, forKey: .creation_date)
        try container.encode(description, forKey: .description)
        try container.encode(is_urgent, forKey: .is_urgent)
        try container.encode(images_url, forKey: .images_url)
        try container.encode(price, forKey: .price)
        try container.encode(siret, forKey: .siret)
    }
}



extension Array where Element == ClassifiedAdApiEntity {
    func toModel() -> [ClassifiedAd] {
        return self.map { apiEntity in
            return ClassifiedAd(apiEntity: apiEntity)
        }
    }
}
