//
//  CategoryAPIEntity.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import Foundation

struct CategoryAPIEntity {
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

extension CategoryAPIEntity: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try? values.decode(Int.self, forKey: .id)
        name = try? values.decode(String.self, forKey: .name)
    }
}

extension CategoryAPIEntity: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}

extension Array where Element == CategoryAPIEntity {
    func toModel() -> [Category] {
        return self.map { apiEntity in
            return Category(apiEntity: apiEntity)
        }
    }
}
