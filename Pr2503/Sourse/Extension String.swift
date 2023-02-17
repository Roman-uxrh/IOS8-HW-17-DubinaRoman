//
//  Exe.swift
//  Pr2503
//
//  Created by admin on 15.02.2023.
//

import Foundation

extension String {
    private static let digits = "0123456789"
    private static let lowercase = "abcdefghijklmnopqrstuvwxyz"
    private static let uppercase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private static let punctuation = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
    private static let letters = lowercase + uppercase
    static let printable = digits + letters + punctuation

    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}
