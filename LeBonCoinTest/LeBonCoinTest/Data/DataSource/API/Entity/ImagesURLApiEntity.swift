//
//  ImagesURLApiEntity.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import Foundation

struct ImagesURLApiEntity {
    var small: String?
    var thumb: String?
    
    enum CodingKeys: String, CodingKey {
        case small
        case thumb
    }
}

extension ImagesURLApiEntity: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        small = try? values.decode(String.self, forKey: .small)
        thumb = try? values.decode(String.self, forKey: .thumb)
    }
}


extension ImagesURLApiEntity: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(small, forKey: .small)
        try container.encode(thumb, forKey: .thumb)
    }
}

