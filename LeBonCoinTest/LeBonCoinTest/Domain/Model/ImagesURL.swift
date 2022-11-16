//
//  ImagesURL.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 10/11/2022.
//

import UIKit

class ImagesURL: NSObject {

    var small: String
    var thumb: String
    
    init(apiEntity: ImagesURLApiEntity) {
        self.small = apiEntity.small ?? ""
        self.thumb = apiEntity.thumb ?? ""
    }
    
    init(small: String, thumb: String) {
        self.small = small
        self.thumb = thumb
    }
}
