//
//  ImagesURL.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import UIKit
extension ImagesURL {
    static func mock() -> ImagesURL {
        let smallSize = 64
        let thumbSize = UIScreen.main.bounds.width
        let thumb: String = "https://picsum.photos/\(thumbSize)/\(thumbSize)"
        let small = "https://picsum.photos/\(smallSize)/\(smallSize)"
        return ImagesURL(small: small, thumb: thumb)
    }
}
