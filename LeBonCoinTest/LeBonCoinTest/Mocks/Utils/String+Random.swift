//
//  String+Random.swift
//  LeBonCoinTest
//
//  Created by dorian cheignon on 16/11/2022.
//

import Foundation
extension String {
    static func random(lenght: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789€.;, "
        return String((0..<lenght).map { _ in letters.randomElement()! })
    }
}
